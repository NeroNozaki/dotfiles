#!/bin/bash

LAYOUT=$(setxkbmap -query | grep "layout" | awk '{print $2}')

if [[ $LAYOUT != "us" ]]; then
    pkill kmonad
    kmonad ~/.config/kmonad/homerowmods-caps-custom.kbd &
    setxkbmap -option
	setxkbmap -layout us -option 'shift:double_capslock_cancel'
    notify-send -u low -t 1500 "Neo" "Disabled"
else
    setxkbmap -option
	setxkbmap -layout de -variant neo -option 'shift:double_capslock_cancel'
    notify-send -u low -t 1500 "Neo" "Enabled"
fi
