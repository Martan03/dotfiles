#!/usr/bin/env bash

# Loads new wallpaper randomly. Expects `PAPER_DIR` to contain wallpaper packs
# (subdirectories) containing wallpaper. Picks random wallpaper from pack,
# different for each wallpaper when possible (works for two monitors).
#
# Usage:
# `./paper_shuffle.sh`

PAPER_DIR="/mnt/hdd/Images/Wallpapers"

PACK=$(find "$PAPER_DIR" -mindepth 1 -maxdepth 1 -type d | shuf -n 1)
mapfile -t WALLS < <(find "$PACK" -type f)

if [ ${#WALLS[@]} -eq 0 ]; then
    echo "No wallpapers in $PACK"
    exit 1
fi

MONITORS=($(hyprctl monitors -j | jq -r '.[].name'))

if [ ${#WALLS[@]} -eq 1 ]; then
    CHOSEN=("${WALLS[0]}" "${WALLS[0]}")
else
    mapfile -t SHUFFLED < <(printf "%s\n" "${WALLS[@]}" | shuf)
    CHOSEN=("${SHUFFLED[@]:0:${#MONITORS[@]}}")
fi

for i in "${!MONITORS[@]}"; do
    hyprctl hyprpaper reload "${MONITORS[i]},${CHOSEN[i]}"
done
