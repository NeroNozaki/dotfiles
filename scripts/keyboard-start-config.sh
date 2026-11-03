#!/usr/bin/env bash

pkill kanata
kanata --cfg ~/.dotfiles/config/kanata/neo2_qwerty_abnt2.kbd &
sleep 3
setxkbmap -option 'shift:both_capslock'
xset r rate 400 20
