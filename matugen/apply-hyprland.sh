#!/bin/bash
color=$(cat ~/.config/hyprland/hyprland-colors.conf)
hyprctl keyword general:col.active_border "rgb($color)"
