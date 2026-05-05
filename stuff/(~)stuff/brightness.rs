use std::env;
use std::fs;
use std::path::Path;
use std::process::{Command, Stdio};

const SHM_PATH: &str = "/dev/shm/waybar_br_val";
const LOCK_PATH: &str = "/dev/shm/waybar_br_lock";

/// Reads the cached brightness value from shared memory.
fn read_val() -> i32 {
    fs::read_to_string(SHM_PATH)
        .ok()
        .and_then(|s| s.trim().parse::<i32>().ok())
        .unwrap_or(50)
}

/// Writes the brightness value to shared memory.
fn write_val(val: i32) {
    let _ = fs::write(SHM_PATH, val.to_string());
}

/// Returns the appropriate icon based on the brightness level.
fn get_icon(val: i32) -> &'static str {
    if val <= 30 {
        "󰃞"
    } else if val <= 70 {
        "󰃟"
    } else {
        "󰃠"
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() > 1 {
        let mut val = read_val();

        match args[1].as_str() {
            "up" => val += 1,
            "down" => val -= 1,
            _ => {}
        }

        val = val.clamp(0, 100);
        write_val(val);

        // 1. UI always updates instantly
        println!("{{\"text\":\"{}  {}%\", \"percentage\":{}}}", get_icon(val), val, val);

        // 2. Hardware Update Logic
        // If no lock exists, start the hardware update loop in the background
        if !Path::new(LOCK_PATH).exists() {
            let cmd = format!(
                "touch {lock}; last=-1; while true; do current=$(cat {shm}); if [ \"$current\" = \"$last\" ]; then break; fi; ddcutil setvcp 10 $current --bus 0 --noverify; last=$current; sleep 0.05; done; rm {lock}",
                lock = LOCK_PATH,
                shm = SHM_PATH
            );

            // Spawn the shell loop and let it run detached
            let _ = Command::new("sh")
                .arg("-c")
                .arg(cmd)
                .stdout(Stdio::null())
                .stderr(Stdio::null())
                .spawn();
        }
    } else {
        // Initial sync from hardware
        let output = Command::new("ddcutil")
            .args(["getvcp", "10", "--bus", "0", "--brief"])
            .output();

        let mut hardware_val = None;
        if let Ok(out) = output {
            let s = String::from_utf8_lossy(&out.stdout);
            // Example brief output: "VCP 10 C 50 ..."
            if let Some(pos) = s.find("C ") {
                let val_str = s[pos + 2..].split_whitespace().next().unwrap_or("");
                hardware_val = val_str.parse::<i32>().ok();
            }
        }

        let val = match hardware_val {
            Some(v) => {
                write_val(v);
                v
            }
            None => read_val(),
        };

        println!("{{\"text\":\"{}  {}%\", \"percentage\":{}}}", get_icon(val), val, val);
    }
}