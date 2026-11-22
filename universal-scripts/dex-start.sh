#!/usr/bin/env bash

if ! xrdb -query | rg -q '^awesome\.dex_autostart:[[:space:]] *true$'; then
    printf 'awesome.dex_autostart: true\n' | xrdb -merge
    dex --autostart --environment Awesome
fi

