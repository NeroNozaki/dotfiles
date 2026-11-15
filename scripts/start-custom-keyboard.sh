#!/usr/bin/env bash

pkill kanata

LOG=$(mktemp)

# Start kanata and capture its logs
kanata --cfg ~/.config/kanata/neo-fix-and-hrm.kbd --nodelay >"$LOG" 2>&1 &
disown

# Wait until kanata is actually ready
timeout=50
while ! grep -q "Starting kanata proper" "$LOG" 2>/dev/null; do
    sleep 0.1
    ((timeout--))
    if ((timeout <= 0)); then
        echo "Timeout waiting for kanata to become ready" >&2
        rm -f "$LOG"
        exit 1
    fi
done

rm -f "$LOG"

# Now it's safe to apply the layout
echo "applying custom keyboard"
setxkbmap -I ~/.config/xkb -layout cu -option "" -print | xkbcomp -I$HOME/.config/xkb - $DISPLAY 2>/dev/null
xset r rate 400 20
