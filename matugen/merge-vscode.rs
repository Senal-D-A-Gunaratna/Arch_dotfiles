use serde_json::{Map, Value};
use std::fs;
use std::path::PathBuf;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Define paths matching the original Python script
    let home = std::env::var("HOME")?;
    let base_path = PathBuf::from(&home).join(".config/VSCodium/User/settings.json");
    let colors_path = PathBuf::from(&home).join(".config/VSCodium/User/vscode-colors.json");

    // 1. Read and parse existing settings
    let mut base_settings: Map<String, Value> = if base_path.exists() && fs::metadata(&base_path)?.len() > 0 {
        let content = fs::read_to_string(&base_path)?;
        serde_json::from_str(&content).map_err(|e| {
            eprintln!("JSON Syntax Error in settings.json: {}", e);
            eprintln!("Check for trailing commas!");
            e
        })?
    } else {
        Map::new()
    };

    // 2. Read new colors from Matugen output
    let colors_content = fs::read_to_string(&colors_path)
        .map_err(|e| format!("Could not read colors path: {}", e))?;
    let colors_data: Value = serde_json::from_str(&colors_content)?;

    // Extract customizations (handles both wrapped or raw Matugen output)
    let new_colors = colors_data
        .get("workbench.colorCustomizations")
        .unwrap_or(&colors_data);

    // 3. Merge logic
    // Remove existing key to re-insert at top later, and merge contents
    let mut color_customizations = base_settings
        .remove("workbench.colorCustomizations")
        .and_then(|v| v.as_object().cloned())
        .unwrap_or_default();

    if let Some(new_colors_map) = new_colors.as_object() {
        for (key, value) in new_colors_map {
            color_customizations.insert(key.clone(), value.clone());
        }
    }

    // 4. Reconstruct: Colors FIRST
    // If 'preserve_order' is enabled in serde_json, this order is reflected in the file.
    let mut final_settings = Map::new();
    final_settings.insert(
        "workbench.colorCustomizations".to_string(),
        Value::Object(color_customizations),
    );

    // Append the rest of the original settings
    for (key, value) in base_settings {
        final_settings.insert(key, value);
    }

    // 5. Write back with 4-space indentation
    let json_output = serde_json::to_string_pretty(&final_settings)?;
    fs::write(base_path, json_output)?;

    println!("Successfully merged colors to the top.");
    Ok(())
}