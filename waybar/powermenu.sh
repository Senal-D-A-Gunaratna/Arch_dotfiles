#!/bin/bash

# Changed the label to "Sleep"
options="Sleep\nLock\nLogout\nReboot\nShutdown"

chosen=$(echo -e "$options" | rofi -dmenu -p "Power")

case "$chosen" in
  Sleep)
    hyprlock & sleep 1 && systemctl suspend ;;
  Lock)
    hyprlock ;;
  Logout)
    uwsm stop ;;
  Reboot)
    systemctl reboot ;;
  Shutdown)
    systemctl poweroff ;;
esac
