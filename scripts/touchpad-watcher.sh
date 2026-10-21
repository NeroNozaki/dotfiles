#!/usr/bin/env bash

# Get the ID of the first device that contains "Touchpad"
TOUCHPAD_ID=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | head -n1 | cut -d= -f2)

if [ -z "$TOUCHPAD_ID" ]; then
    echo "No touchpad found"
    exit 1
fi

update_touchpad() {
    # Re-check the ID in case it changed
    TOUCHPAD_ID=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | head -n1 | cut -d= -f2)

    if [ -z "$TOUCHPAD_ID" ]; then
        return
    fi

    # Check for real external mice
    if xinput list | grep -i "slave  pointer" \
        | grep -v -i "touchpad" \
        | grep -v -i "virtual core" \
        | grep -v -i "DELL08CA:00 04F3:30C4 Mouse" \
        | grep -v -i "ImPS/2 Logitech Wheel Mouse" \
        | grep -q .; then
        xinput disable "$TOUCHPAD_ID" 2>/dev/null
    else
        xinput enable "$TOUCHPAD_ID" 2>/dev/null
    fi
}

# Run once at start
update_touchpad

# Now watch for device add/remove events
udevadm monitor --udev --subsystem-match=input | while read -r line; do
    if echo "$line" | grep -qE 'add|remove'; then
        # Small delay so the device is fully registered
        sleep 0.3
        update_touchpad
    fi
done
