#!/bin/bash

timeout=50

while ! wmctrl -l | grep -q "Godot"; do
    sleep 0.1
    ((timeout--))

    if ((timeout <= 0)); then
        exit 1
    fi
done

wmctrl -r "Godot" -t 2


