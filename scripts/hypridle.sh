#!/usr/bin/env bash

STATE_FILE="/dev/shm/hypridle_state"

# Helper functions to fetch current states safely
get_current_brightness() {
  # Use --terse to get "VCP 10 C <current> <max>" and extract the 4th field
  ddcutil getvcp 10 --terse | awk '{print $4}'
}


case "$1" in
apply)
  if [ -f "$STATE_FILE" ]; then
    echo "Presets already applied. Revert first."
    exit 1
  fi

  echo "Saving current states to RAM..."
  CURRENT_B=$(get_current_brightness)

  # Fail-safe check: Ensure we actually grabbed a valid brightness number
  if [[ -z "$CURRENT_B" || ! "$CURRENT_B" =~ ^[0-9]+$ ]]; then
    echo "Error: Failed to parse current brightness from ddcutil."
    exit 1
  fi

  echo "$CURRENT_B" >"$STATE_FILE"

  echo "Applying custom presets..."
  ddcutil setvcp 10 10
  echo "Done."
  ;;

revert)
  if [ ! -f "$STATE_FILE" ]; then
    echo "No saved state found in RAM."
    exit 1
  fi

  echo "Restoring original states from RAM..."
  read -r ORIG_BRIGHTNESS <"$STATE_FILE"

  ddcutil setvcp 10 "$ORIG_BRIGHTNESS"

  echo "Clearing RAM data..."
  rm -f "$STATE_FILE"
  echo "Done."
  ;;

*)
  echo "Usage: $0 {apply|revert}"
  exit 1
  ;;
esac
