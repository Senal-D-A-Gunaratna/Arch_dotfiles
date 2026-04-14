#!/bin/bash
color=$(cat ~/.cache/matugen/hyprland-colors.conf)
hyprctl keyword general:col.active_border "rgb($color)"
