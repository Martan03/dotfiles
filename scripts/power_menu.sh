#!/usr/bin/bash

choice=$(printf "Suspend\nShutdown\nReboot" | rofi -dmenu -p "Power Menu")

case "$choice" in
Shutdown) shutdown now ;;
Reboot) systemctl reboot -i ;;
Suspend)
    hyprlock &
    sleep 0.1 &
    systemctl suspend -i
    ;;
*) exit 1 ;;
esac
