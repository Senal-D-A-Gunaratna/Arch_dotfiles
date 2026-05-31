#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
ROFI_THEME="$HOME/.config/rofi/wallpaper-grid.rasi"
THEMING_DELAY="1"

mkdir -p "$THUMB_DIR"

if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Picker" "Directory $WALL_DIR not found."
    exit 1
fi

# Generate thumbnails for new or updated files
find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | while read -r img; do
    # Create a unique flat filename for the thumbnail cache
    rel_path=$(realpath --relative-to="$WALL_DIR" "$img")
    thumb_name=$(echo "$rel_path" | tr '/' '-')
    thumb_path="$THUMB_DIR/$thumb_name.png"

    # Convert to thumbnail if it doesn't exist or if original is newer
    if [ ! -f "$thumb_path" ] || [ "$img" -nt "$thumb_path" ]; then
        # Use [0] to ensure only the first frame of a GIF is extracted
        magick "$img[0]" -thumbnail 240x135^ -gravity center -extent 240x135 "$thumb_path" 2>/dev/null &
    fi
done
wait # Ensure conversions finish

# Build the custom input string for Rofi with icon markers
ROFI_INPUT=""
while read -r img_rel; do
    thumb_name=$(echo "$img_rel" | tr '/' '-')
    thumb_path="$THUMB_DIR/$thumb_name.png"

    # Format: Display Name\0icon\x1f/path/to/icon
    ROFI_INPUT+="$img_rel\x00icon\x1f$thumb_path\n"
done < <(cd "$WALL_DIR" && find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | sed 's|^\./||')

# Run Rofi using a dedicated grid theme layout
CHOICE=$(echo -en "$ROFI_INPUT" | rofi -dmenu -i -p "󰸉 Wallpapers" -config "$ROFI_THEME")

if [ -z "$CHOICE" ]; then
    exit 0
fi

FULL_PATH="$WALL_DIR/$CHOICE"

# Apply wallpaper using awww with center transition and 2s duration
awww img --transition-type center --transition-duration $THEMING_DELAY "$FULL_PATH"

# Update system colors using matugen
$THEMING_DELAY && matugen image "$FULL_PATH" --source-color-index 0
