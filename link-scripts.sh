#!/usr/bin/env bash
set -euo pipefail

SOURCE="$HOME/.dotfiles/universal-scripts"
TARGET="$HOME/.local/bin"

mkdir -p "$TARGET"

for script in "$SOURCE"/*; do
    [[ -f "$script" && -x "$script" ]] || continue

    name="${script##*/}"
    ln -sfnv "$script" "$TARGET/$name"
done
