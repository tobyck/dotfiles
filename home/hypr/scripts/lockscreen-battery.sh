percentage=$(upower -d | grep -Po ".{1,3}(?=%)" | head -1 | tr -d " ")

if [[ $percentage -lt 20 ]] then
	colour="#f7768e"
	symbol="󰂃"
else
	colour="#7aa2f7"
	symbol="󰁹"
fi

if [[ $(upower -d | egrep "state:\s+charging") ]] then
	symbol="󰂄"
fi

echo "<span foreground='$colour'>$symbol $percentage%</span>"
