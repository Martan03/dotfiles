#!/usr/bin/bash

theme="$HOME/.config/rofi/themes/kumuhana-powermenu.rasi"
suspend=''
shutdown=''
reboot=''

uptime=$(uptime -p | sed 's/up //')

run_rofi() {
	rofi -dmenu -p "Uptime: $uptime" -theme $theme
}

choice=$(printf "$suspend\n$shutdown\n$reboot" | run_rofi)

case "$choice" in
$shutdown) systemctl poweroff -i ;;
$reboot) systemctl reboot -i ;;
$suspend)
	hyprlock &
	sleep 0.1 &
	systemctl suspend -i
	;;
*) exit 1 ;;
esac
