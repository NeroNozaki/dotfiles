#!/usr/bin/env bash
set -e

session="arduino-cli"
dir="$HOME/programming/esp32"

if ! tuios ls | rg -Fq "$session"; then
    # Create the session with its initial shell.
    tuios new "$session" --detach --cwd "$dir"

    # Workspace 1: Neovim.
    tuios send-text -s "$session" -w 0 $'nvim .\n'

    # Workspace 2: Arduino CLI shell.
    # It needs write/respond to control the monitor pane.
    tuios new-window cli \
        --session "$session" \
        --workspace 2 \
        --cwd "$dir" \
        --no-focus \
        --grants write,respond

    # Workspace 3: Serial monitor shell.
    # No grants are needed for the monitor itself.
    tuios new-window monitor \
        --session "$session" \
        --workspace 3 \
        --cwd "$dir" \
        --no-focus \
        --grants none

fi

# Initialize the Arduino CLI shell.
tuios send-text -s "$session" -w cli \
    $'clear\nsource "$HOME/.config/tuios/scripts/arduino.sh"\nclear\narduino-cli board list\n'

# Start the serial monitor.
tuios send-text -s "$session" -w monitor \
    $'clear\narduino-cli monitor -p /dev/ttyUSB0 -c baudrate=115200\n'

# Attach to the session, focusing workspace 2.
exec tuios attach "$session"
