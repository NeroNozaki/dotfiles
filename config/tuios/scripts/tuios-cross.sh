#!/usr/bin/env bash
set -e

session="cross-adventures"
dir="/mnt/HD/godot-projects/$session"

# If the session already exists, just attach to it.
if tuios ls --json | jq -e --arg name "$session" \
    'any(.[]; .name == $name)' >/dev/null 2>&1; then
    exec tuios attach "$session"
fi

# Create the session, initially with one shell in workspace 1.
tuios new "$session" --detach --cwd "$dir"

# Workspace 1: Neovim
tuios send-text -s "$session" -w 0 $'nvim .\n'

# Workspace 2: Bash
tuios new-window bash \
    --session "$session" --workspace 2 --cwd "$dir" --no-focus \

tuios send-text -s "$session" -w bash $'$HOME/.dotfiles/scripts/wait-godot.sh\n'

# Workspace 3: OpenCode
tuios new-window opencode \
    --session "$session" --workspace 3 --cwd "$dir" --no-focus \
    -- opencode

# Workspace 4: Godot editor
tuios new-window godot-editor \
    --session "$session" --workspace 4 --cwd "$dir" --no-focus \
    -- godot -e

# Attach to the session.
exec tuios attach "$session"
