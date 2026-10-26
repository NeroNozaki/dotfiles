#!/usr/bin/env bash

kanata --cfg ~/.config/kanata/neoqwerty.kbd &
setxkbmap -option 'shift:both_capslock'
xset r rate 400 20
