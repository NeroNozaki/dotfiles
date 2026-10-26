#!/usr/bin/env bash

if ps -eo args | rg -q 'kanata.*neoqwerty\.kbd'; then
    state=1
else
    state=0
fi

if [[ $state -eq 1 ]]; then
    pkill kanata
    kanata --cfg ~/.dotfiles/config/kanata/neoqwerty-nomods.kbd &
    sleep 1
    setxkbmap -option 'shift:both_capslock'
    xset r rate 400 20
    notify-send -u low -t 1500 "Mods" "Off"
else
    pkill kanata
    kanata --cfg ~/.dotfiles/config/kanata/neoqwerty.kbd &
    sleep 1
    setxkbmap -option 'shift:both_capslock'
    xset r rate 400 20
    notify-send -u low -t 1500 "Mods" "On"
fi


