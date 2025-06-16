#!/usr/bin/env bash

if [[ $1 == "clear" ]]; then
    cliphist wipe
    exit 0
fi

sel=$(cliphist list | rofi -dmenu -p "Clipboard")

if [[ -z "$sel" ]]; then
    exit 0
fi

echo "$sel" | cliphist decode | wl-copy
