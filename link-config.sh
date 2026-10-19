#!/usr/bin/env bash

src="$HOME/.dotfiles/config"
dst="$HOME/.config"

mkdir -p "$dst"

for entry in "$src"/* "$src"/.[!.]* "$src"/..?*; do
    [[ -e "$entry" || -L "$entry" ]] || continue

    ln -sfn "$entry" "$dst/"
done
