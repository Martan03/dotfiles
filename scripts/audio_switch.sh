#!/usr/bin/bash

# Switches to the next audio device.

devices=($(pactl list short sinks | awk '{print $2}'));
active=$(pactl get-default-sink);

active_id=0;
for device in ${devices[@]}
do
    active_id=$((active_id + 1))
    if [ $active = $device ]; then
        break;
    fi
done

active_id=$((active_id % ${#devices[@]}));
pactl set-default-sink ${devices[$active_id]};
