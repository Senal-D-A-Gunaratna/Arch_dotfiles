#!/usr/bin/env bash

# Single file to store original values in RAM
STATE_FILE="/dev/shm/skl_state"

# Helper functions to fetch current states
get_current_brightness() {
  ddcutil getvcp 10 | awk -F', text=' '{print $1}' | awk -F'current value =' '{print $2}' | tr -d ' '
}

get_current_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}'
}

case "$1" in
apply)
  if [ -f "$STATE_FILE" ]; then
    echo "Presets already applied. Revert first."
    exit 1
  fi

  echo "Saving current states to RAM..."
  # Grab values and save them on a single line: "brightness volume"
  CURRENT_B=$(get_current_brightness)
  CURRENT_V=$(get_current_volume)
  echo "$CURRENT_B $CURRENT_V" >"$STATE_FILE"

  echo "Applying custom presets..."
  ddcutil setvcp 10 35
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.30
  echo "Done."
  ;;

revert)
  if [ ! -f "$STATE_FILE" ]; then
    echo "No saved state found in RAM."
    exit 1
  fi

  echo "Restoring original states from RAM..."
  # Read both values from the single file
  read -r ORIG_BRIGHTNESS ORIG_VOLUME <"$STATE_FILE"

  ddcutil setvcp 10 "$ORIG_BRIGHTNESS"
  wpctl set-volume @DEFAULT_AUDIO_SINK@ "$ORIG_VOLUME"

  echo "Clearing RAM data..."
  rm -f "$STATE_FILE"
  echo "Done."
  ;;

*)
  echo "Usage: $0 {apply|revert}"
  exit 1
  ;;
esac
