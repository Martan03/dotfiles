#!/usr/bin/bash

# Display wallpaper picker and then sets selected wallpaper using `awww`,
# reloads colors using `wallust and reloads waybar.
#
# Usage:
# `./paper_sel.sh [wallpaper_directory]`

set -e

THEME="$HOME/.config/rofi/themes/paper-picker.rasi"
PAPER_DIR=${1:-/mnt/hdd/Images/Wallpapers}

# Transition configuration
TYPE="center"
DURATION=2
FPS=60

mapfile -t PACKS < <(find "$PAPER_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

RND_PACK="${PACKS[$((RANDOM % ${#PACKS[@]}))]}"
RND_PACK_NAME="¯\_('')_/¯ (rng)"

run_rofi() {
    rofi -i -show -dmenu -config $THEME
}

menu() {
    rnd_cover=$(find "$RND_PACK" -type f \( -iname "*.jpg" -o -iname "*.png" \
        -o -iname "*.webp" -o -iname "*.gif" \) -print -quit)
    printf "%s\x00icon\x1f%s\n" "$RND_PACK_NAME" "$rnd_cover"

    for path in "${PACKS[@]}"; do
        name=$(basename "$path")
        cover=$(find "$path" -type f \( -iname "*.jpg" -o -iname "*.png" \
            -o -iname "*.webp" -o -iname "*.gif" \) -print -quit)
        if [[ -z $cover ]]; then
            continue
        fi
        printf "%s\x00icon\x1f%s\n" "$(echo "$name" | cut -d. -f1)" "$cover"
    done
}

set_paper() {
    params="--transition-fps $FPS --transition-duration $DURATION"
    awww img "$1" -o "$2" --transition-type "$TYPE" $params
}

reload_colors() {
    wallust run $1
    $WAYBAR_RES
}

awww query || awww-daemon --format xrgb

choice=$(menu | run_rofi)
choice=$(echo "$choice" | xargs)
RND_PACK_NAME=$(echo "$RND_PACK_NAME" | xargs)

if [[ -z "$choice" ]]; then
    exit 0;
fi

sel_pack=""
if [[ "$choice" == "$RND_PACK_NAME" ]]; then
    sel_pack=$RND_PACK
else
    sel_pack="$PAPER_DIR/$choice"
fi

mapfile -d '' PAPERS < <(find "$sel_pack" -type f \( \
    -iname "*.jpg" \
    -o -iname "*.png" \
    -o -iname "*.jpeg" \
    -o -iname "*.webp" \
\) -print0)

MONITORS=($(hyprctl monitors -j | jq -r '.[].name'))

chosen=()
len=${#PAPERS[@]}
if [ $len -eq 1 ]; then
    for _ in "${MONITORS[@]}"; do chosen+=("${PAPERS[0]}"); done
else
    mapfile -t SHUFFLED < <(printf "%s\n" "${PAPERS[@]}" | shuf)

    for i in "${MONITORS[@]}"; do
        chosen+=("${SHUFFLED[$((i % $len))]}")
    done
fi

for i in "${!MONITORS[@]}"; do
    set_paper "${chosen[$i]}" "${MONITORS[$i]}" &
done

sleep $(( DURATION / 2 ))
wallust run "${chosen[0]}"
sleep 0.2

pkill -SIGUSR2 waybar
makoctl reload
