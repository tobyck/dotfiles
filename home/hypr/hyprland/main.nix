{

	wayland.windowManager.hyprland.settings = let
		theme = builtins.fetchurl {
			url = "https://raw.githubusercontent.com/rose-pine/hyprland/6898fe967c59f9bec614a9a58993e0cb8090d052/rose-pine.conf";
			sha256 = "sha256:0q4zna3njimn2ffaincjcxyiyx8qlz625q6n4k3qbxwqbmvdlcc2";
		};
	in {
		source = theme;

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
			"swaybg -i ${../../wallpapers/gradient2.png}"
		];

		debug = {
			disable_logs = false;
		};
		
		general = {
			layout = "dwindle";
			allow_tearing = false;
		};

		input = {
			kb_layout = "us";

			follow_mouse = 1;

			touchpad = {
				natural_scroll = true;
				tap-to-click = false;
				clickfinger_behavior = true;
			};

			sensitivity = 0;
		};

		gestures = {
			workspace_swipe = "on";
			workspace_swipe_cancel_ratio = 0.3;
		};

		dwindle = {
			pseudotile = "yes";
			preserve_split = "yes";
		};

		windowrulev2 = [ "suppressevent maximize, class:.*" ];

		monitor = [ ", preferred, auto, auto" ];
		
		env = [ "QT_QPA_PLATFORMTHEME,qt5ct" ];

		misc = {
			force_default_wallpaper = 0;
			vfr = "on";
		};
	};
}
