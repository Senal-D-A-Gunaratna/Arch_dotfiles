# Auto-start UWSM-managed Hyprland on TTY1
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    exec uwsm start hyprland-uwsm.desktop
fi
