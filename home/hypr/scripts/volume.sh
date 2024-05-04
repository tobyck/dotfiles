if [[ $1 != "up" ]] && [[ $1 != "down" ]] && [[ $1 != "toggle" ]]; then
    echo "Error: must specify up or down as the first argument"
    exit 1
fi

step=5
is_muted=$(amixer sget Master | grep -o "\[off\]")
set_cmd="amixer sset Master"

function current_vol() {
    echo $(amixer sget Master | grep -o "[0-9]*%" | head -n 1 | grep -o "[0-9]*")
}

if [[ $1 == "up" ]]; then
    if [[ $is_muted ]]; then
        $set_cmd unmute
    fi
    $set_cmd $step%+
elif [[ $1 == "down" ]]; then
	if [[ $is_muted ]]; then
		$set_cmd unmute
	fi
	$set_cmd $step%-
	if [[ "$(current_vol)" == 0 ]]; then
		$set_cmd mute
	fi
elif [[ "$(current_vol)" != 0 ]]; then
    $set_cmd toggle
fi
