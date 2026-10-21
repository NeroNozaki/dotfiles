#!/usr/bin/env bash

set -u

get_touchpad() {
    hyprctl -j devices | jq -r '
        [.mice[] | select(.name | test("touchpad"; "i")) | .name]
        | first // empty
    '
}

has_external_mouse() {
    hyprctl -j devices | jq -e '
        [.mice[].name
         | select(test("touchpad"; "i") | not)
         | select(test(
             "dell08ca:00-04f3:30c4-mouse|imps/2-logitech-wheel-mouse|my-kmonad-output-1";
             "i"
           ) | not)]
        | length > 0
    ' >/dev/null
}


STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/touchpad-state"

set_touchpad() {
    local name="$1"
    local enabled="$2"

    if hyprctl eval "hl.device({ name = [[$name]], enabled = $enabled })"; then
        if [[ "$enabled" == "true" ]]; then
            echo enabled > "$STATE_FILE"
        else
            echo disabled > "$STATE_FILE"
        fi
    fi
}

update_touchpad() {
    local touchpad
    touchpad=$(get_touchpad)

    if [[ -z "$touchpad" ]]; then
        echo "No touchpad found"
        return
    fi

    if has_external_mouse; then
        set_touchpad "$touchpad" false
        echo "External mouse detected: touchpad disabled"
    else
        set_touchpad "$touchpad" true
        echo "No external mouse: touchpad enabled"
    fi
}

# Apply the correct state at startup.
update_touchpad

# Watch for input-device additions and removals.
udevadm monitor --udev --subsystem-match=input |
while IFS= read -r line; do
    if [[ "$line" =~ (add|remove) ]]; then
        sleep 0.3
        update_touchpad
    fi
done
