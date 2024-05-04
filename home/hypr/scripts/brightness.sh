# steps as percentages
main_step=8
small_step=2
step_switch=20 # when to switch step sizes

# this will be built up then run
command=brightnessctl

# add the device if it's specified
if [ $2 ]; then
    command+=" -d $2"
fi

if [[ $(brightnessctl | grep -o "[0-9]*%" | grep -o "[0-9]*") -le $step_switch ]]; then
    step=$small_step
else
    step=$main_step
fi

if [[ $1 == up ]]; then
    command+=" set +$step%"
elif [[ $1 == down ]]; then
    command+=" set $step%-"
else
    echo "Error: please specify up or down in the first argument."
    exit 1
fi

$command
