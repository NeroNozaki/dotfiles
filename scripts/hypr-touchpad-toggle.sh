
#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/touchpad-state"

touchpad=$(hyprctl -j devices | jq -r '
    [.mice[] | select(.name | test("touchpad"; "i")) | .name]
    | first // empty
')

if [[ -z "$touchpad" ]]; then
    notify-send "Touchpad" "No touchpad found"
    exit 1
fi

if [[ -f "$STATE_FILE" ]] &&
   [[ "$(cat "$STATE_FILE")" == "enabled" ]]; then
    enabled=false
else
    enabled=true
fi

hyprctl eval "hl.device({ name = [[$touchpad]], enabled = $enabled })" &

if [[ "$enabled" == "true" ]]; then
    echo enabled > "$STATE_FILE"
    notify-send "Touchpad enabled"
else
    echo disabled > "$STATE_FILE"
    notify-send "Touchpad disabled"
fi
