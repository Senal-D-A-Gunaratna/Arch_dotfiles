#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    pkill -x "hyprsunset"
    notify-send -u low -t 2000 "Hyprsunset" "Blue light filter Disabled"
else
    hyprsunset &
    notify-send -u low -t 2000 "Hyprsunset" "Blue light filter Enabled"
fi