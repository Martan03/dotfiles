#!/usr/bin/env bash
# Displays currently playing media

players=("firefox" "spotify")
max_length=40

truncate() {
    local str="$1"
    local maxlen="$2"

    if ((${#str} > maxlen)); then
        local cut="${str:0:maxlen}"
        cut="${cut%"${cut##*[![:space:]]}"}"
        echo "${cut}..."
    else
        echo "$str"
    fi
}

for player in "${players[@]}"; do
    status=$(playerctl --player=$player status 2>/dev/null)

    if [[ "$status" != "Playing" ]]; then
        continue
    fi

    artist=$(playerctl --player=$player metadata artist 2>/dev/null)
    title=$(playerctl --player=$player metadata title 2>/dev/null)

    if [[ -z "$title" ]]; then
        continue;
    fi
    
    if [[ -n "$artist" ]]; then
        output="$artist - $title"
    else
        output="$title"
    fi

    output=$(truncate "$output" $max_length)
    escaped_output=$(printf ' %s' "$output" | jq -Rsa)

    echo "{\"text\": $escaped_output, \"class\": \"playing\"}"
    exit 0
done

echo '{"text": "", "class": "", "tooltip": false}'
exit 0
