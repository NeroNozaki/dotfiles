#!/bin/bash

TOUCHPAD="DELL08CA:00 04F3:30C4 Touchpad"

state=$(xinput list-props "$TOUCHPAD" | grep -i "device enabled" | awk '{print$4}')

if [[ "$state" -eq 1 ]]; then
    xinput disable "$TOUCHPAD"
    notify-send -u low -t 1500 "Touchpad" "Disabled"
else
    xinput enable "$TOUCHPAD"
    notify-send -u low -t 1500 "Touchpad" "Enabled"
fi

