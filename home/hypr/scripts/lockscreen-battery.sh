percentage=$(upower -d | grep -Po ".{1,3}(?=%)" | head -1 | tr -d " ")

if [[ $percentage -lt 20 ]] then
	colour="eb6f92"
	symbol="󰂃"
else
	colour="ebbcba"
	symbol="󰁹"
fi

if [[ $(upower -d | egrep "state:\s+charging") ]] then
	symbol="󰂄"
fi

echo "<span foreground='#$colour'>$symbol $percentage%</span>"
