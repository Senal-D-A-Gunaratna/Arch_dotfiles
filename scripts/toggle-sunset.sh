#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    pkill -x "hyprsunset"
    dunstify -u low -t 2000 "Hyprsunset" "Blue light filter disabled"
else
    hyprsunset &
    dunstify -u low -t 2000 "Hyprsunset" "Blue light filter enabled"
fi