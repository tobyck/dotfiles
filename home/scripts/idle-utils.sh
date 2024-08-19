if [[ $1 == "dim" ]]; then
	brightnessctl -s set 10
	brightnessctl -sd kbd_backlight set 0
elif [[ $1 == "bright" ]]; then
	brightnessctl -r
	brightnessctl -rd kbd_backlight
elif sway --get-socketpath; then
	if [[ $1 == "lock" ]]; then
		pidof swaylock-fancy || swaylock-fancy -t "\n\n\n\n\n\n\nType password to unlock"
	elif [[ $1 == "dpms-off" ]]; then
		swaymsg "output * dpms off"
	elif [[ $1 == "dpms-on" ]]; then
		swaymsg "output * dpms on"
	fi
else
	if [[ $1 == "lock" ]]; then
		pidof hyprlock || hyprlock
	elif [[ $1 == "dpms-off" ]]; then
		hyprctl dispatch dpms off
	elif [[ $1 == "dpms-on" ]]; then
		hyprctl dispatch dpms on
	fi
fi
