#!/usr/bin/env bash
PICK=$(waypaper --list | grep -o '"wallpaper": *"[^"]*"' | cut -d'"' -f4)
[[ -f "$PICK" ]] && matugen image "$PICK" --source-color-index 0
