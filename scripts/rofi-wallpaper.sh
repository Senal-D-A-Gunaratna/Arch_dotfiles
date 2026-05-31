#!/usr/bin/env bash

# Define paths (Using the exact lowercase path from your tree output)
WALL_DIR="$HOME/Pictures/wallpapers"
MATUGEN_SCRIPT="$HOME/.config/scripts/matugen-wall.sh"

# 1. Gather all files relative to WALL_DIR to keep Rofi clean but preserve the subfolder context
# This handles files inside 'gif/', 'other/', and any future folders.
if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Picker" "Directory $WALL_DIR not found."
    exit 1
fi

# Find images/gifs, strip the leading WALL_DIR path for a cleaner Rofi menu
SELECTION_LIST=$(cd "$WALL_DIR" && find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | sed 's|^\./||')

# 2. Feed the list to Rofi
# -dmenu enables piping, -i makes search case-insensitive
CHOICE=$(echo "$SELECTION_LIST" | rofi -dmenu -i -p "󰸉 Select Wallpaper" -config "$HOME/.config/rofi/config.rasi")

# If the user exits Rofi without selecting anything, quit safely
if [ -z "$CHOICE" ]; then
    exit 0
fi

# 3. Reconstruct the absolute path to the file
FULL_PATH="$WALL_DIR/$CHOICE"

# 4. Hand off the file to your Matugen & SWWW script
if [ -x "$MATUGEN_SCRIPT" ]; then
    "$MATUGEN_SCRIPT" "$FULL_PATH"
else
    notify-send "Wallpaper Picker" "Error: $MATUGEN_SCRIPT is missing or not executable."
    exit 1
fi
