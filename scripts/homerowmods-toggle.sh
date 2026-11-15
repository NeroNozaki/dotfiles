#!/usr/bin/env bash

if ps -eo args | rg -q 'kanata.*neo-fix-and-hrm\.kbd'; then
    state=1
else
    state=0
fi

if [[ $state -eq 1 ]]; then
    pkill kanata
    xset r rate 400 20
    notify-send -u low -t 1500 "Mods" "Off"
else
    start-custom-keyboard
    notify-send -u low -t 1500 "Mods" "On"
fi


