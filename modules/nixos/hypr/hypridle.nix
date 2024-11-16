{
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				lock_cmd = "${../scripts/idle-utils.sh} lock";
				before_sleep_cmd = "loginctl lock-session";
				after_sleep_cmd = "${../scripts/idle-utils.sh} dpms-on";
			};

			listener = [
				{
					timeout = 120; # dim screen and keyboard after 2 mins
					on-timeout = "${../scripts/idle-utils.sh} dim";
					on-resume = "${../scripts/idle-utils.sh} bright";
				}
				{
					timeout = 150; # lock screen 30s later
					on-timeout = "loginctl lock-session";
				}
				{
					timeout = 165; # turn off screen 15s after that
					on-timeout = "${../scripts/idle-utils.sh} dpms-off";
					on-resume = "${../scripts/idle-utils.sh} dpms-on";
				}
				{
					timeout = 900; # suspend after 15mins
					on-timeout = "systemctl suspend";
				}
			];
		};
	};
}
