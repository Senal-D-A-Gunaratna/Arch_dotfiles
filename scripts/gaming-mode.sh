#!/usr/bin/env bash

STATE_FILE="/dev/shm/skl_state"

# Presets
BRIGHTNESS="40"
VOLUME="40"

# Helper functions to fetch current states safely
get_current_brightness() {
  # Use --terse to get "VCP 10 C <current> <max>" and extract the 4th field
  ddcutil getvcp 10 --terse | awk '{print $4}'
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
  CURRENT_B=$(get_current_brightness)
  CURRENT_V=$(get_current_volume)

  # Fail-safe check: Ensure we actually grabbed a valid brightness number
  if [[ -z "$CURRENT_B" || ! "$CURRENT_B" =~ ^[0-9]+$ ]]; then
    echo "Error: Failed to parse current brightness from ddcutil."
    exit 1
  fi

  echo "$CURRENT_B $CURRENT_V" >"$STATE_FILE"

  echo "Applying custom presets..."
  ddcutil setvcp 10 $BRIGHTNESS
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.$VOLUME
  echo "Done."
  ;;

revert)
  if [ ! -f "$STATE_FILE" ]; then
    echo "No saved state found in RAM."
    exit 1
  fi

  echo "Restoring original states from RAM..."
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
