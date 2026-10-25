#!/usr/bin/env bash

LAYOUT=$(setxkbmap -query | grep "layout" | awk '{print $2}')

if [[ $LAYOUT != "us" ]]; then
    pkill kanata
    kanata --cfg ~/.config/kanata/neoqwerty.kbd &
    setxkbmap -option
    setxkbmap -layout us -option 'shift:both_capslock'
    notify-send -u low -t 1500 "Neo" "Disabled"
else
    setxkbmap -option
    setxkbmap -layout de -variant neo -option 'shift:both_capslock'
    notify-send -u low -t 1500 "Neo" "Enabled"
fi
