area=$(slurp)

if [[ $? == 0 ]] then
	exec wf-recorder -f "$1" -g "$area"
fi
