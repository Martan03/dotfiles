#!/usr/bin/bash

# Display wallpaper picker and then sets selected wallpaper using `awww`,
# reloads colors using `wallust and reloads waybar.
#
# Usage:
# `./paper_sel.sh [wallpaper_directory]`

THEME="$HOME/.config/rofi/themes/paper-picker.rasi"
PAPER_DIR=${1:-/mnt/hdd/Images/Wallpapers}
WAYBAR_RES="$HOME/.config/waybar/restart.sh"

# Transition configuration
TYPE="center"
DURATION=2
FPS=60

monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
mapfile -d '' PAPERS < <(find "$PAPER_DIR" -type f \( \
    -iname "*.jpg" \
    -o -iname "*.png" \
    -o -iname "*.jpeg" \
    -o -iname "*.webp" \
\) -print0)

RND_PAPER="${PAPERS[$((RANDOM % ${#PAPERS[@]}))]}"
RND_PAPER_NAME="¯\_('')_/¯"

run_rofi() {
    rofi -i -show -dmenu -config $THEME
}

menu() {
    IFS=$'\n' sorted=($(sort <<<"${PAPERS[*]}"))
    printf "%s\x00icon\x1f%s\n" "$RND_PAPER_NAME" "$RND_PAPER"

    for path in "${sorted[@]}"; do
        name=$(basename "$path")
        printf "%s\x00icon\x1f%s\n" "$(echo "$name" | cut -d. -f1)" "$path"
    done
}

find_set_paper() {
    local -n arr=$1
    local needle=$2

    for i in "${!arr[@]}"; do
        path="${arr[$i]}"
        filename=$(basename "$path")
        if [[ "$filename" == "$needle"* ]]; then
            set_paper "$path"
            return 0
        fi
    done
    return 1
}

set_paper() {
    echo "$1"
    params="--transition-fps $FPS --transition-duration $DURATION"
    awww img "$1" -o "$monitor" --transition-type "$TYPE" $params
    wallust run $1
    $WAYBAR_RES
}

awww query || awww-daemon --format xrgb

choice=$(menu | run_rofi)
choice=$(echo "$choice" | xargs)
RND_PAPER_NAME=$(echo "$RND_PAPER_NAME" | xargs)

if [[ -z "$choice" ]]; then
    exit 0;
fi

case "$choise" in
$RND_PAPER_NAME) set_paper $RANDOM_PIC ;;
*) find_set_paper PAPERS "$choice" ;;
esac
