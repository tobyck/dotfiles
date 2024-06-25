{
	wayland.windowManager.hyprland.settings = {
		"$terminal" = "kitty";
		"$browser" = "firefox";

		"$volume" = "${../scripts/volume.sh}";
		"$brightness" = "${../scripts/brightness.sh}";
		"$screen_rec" = "${../scripts/screen-record.sh}";
		"$kbd_backlight_name" = "kbd_backlight";

		exec-once = [
			"hypridle"
		];

		exec = [
			"swaybg -i ${../../wallpapers/snowflake1.png}"
			"ags"
		];

		debug = {
			disable_logs = false;
		};
		
		general = {
			layout = "master";
			allow_tearing = false;
		};

		input = {
			kb_layout = "us";

			follow_mouse = 1;

			touchpad = {
				natural_scroll = "on";
				tap-to-click = false;
				clickfinger_behavior = "on";
				disable_while_typing = "no";
			};

			sensitivity = 0.2;
		};

		gestures = {
			workspace_swipe = "on";
			workspace_swipe_cancel_ratio = 0.3;
		};

		dwindle = {
			pseudotile = "yes";
			preserve_split = "yes";
		};

		master = {
			allow_small_split = "yes";
			new_is_master = "no";
		};

		windowrulev2 = [ "suppressevent maximize, class:.*" ];

		monitor = [ ", preferred, auto, auto" ];
		
		env = [
			"QT_QPA_PLATFORMTHEME,qt5ct" 
			"XCURSOR_SIZE,24"
		];

		misc = {
			force_default_wallpaper = 0;
			vfr = "on";
		};

		xwayland = {
			force_zero_scaling = "on";
		};
	};
}
