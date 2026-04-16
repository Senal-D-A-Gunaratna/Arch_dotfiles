#!/bin/bash
color=$(cat ~/.config/hypr/hyprland-colors.conf)
hyprctl keyword general:col.active_border "rgb($color)"
