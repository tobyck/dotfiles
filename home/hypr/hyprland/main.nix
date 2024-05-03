{ pkgs, ... }:

{
	home.file.".local/share/icons/rose-pine-hyprcursor" = {
		source = pkgs.fetchFromGitHub {
		  owner = "ndom91";
		  repo = "rose-pine-hyprcursor";
		  rev = "7e0473876f0e6d2308813a78fe84a6c6430b112b";
		  hash = "sha256-wLuFLI6S5DOretqJN05+kvrs8cbnZKfVLXrJ4hvI/Tg=";
		} + "/hyprcursors_uncompressed";
		recursive = true;
	};

	wayland.windowManager.hyprland.settings = let
		theme = builtins.fetchurl {
			url = "https://raw.githubusercontent.com/rose-pine/hyprland/6898fe967c59f9bec614a9a58993e0cb8090d052/rose-pine.conf";
			sha256 = "sha256:0q4zna3njimn2ffaincjcxyiyx8qlz625q6n4k3qbxwqbmvdlcc2";
		};
	in {
		source = theme;

		"$terminal" = "kitty";
		"$browser" = "firefox";

		"$volume" = "${./scripts/volume.sh}";
		"$brightness" = "${./scripts/brightness.sh}";
		"$screen_rec" = "${./scripts/screen-record.sh}";
		"$kbd_backlight_name" = "kbd_backlight";

		exec = [
			"swaybg -i ${../../wallpapers/ocean.jpg}"
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
				# temporary until I fix Hyprland on Home Manager and the two settings above take effect
				disable_while_typing = true;
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

		windowrulev2 = [
			"suppressevent maximize, class:.*"
			# "opacity 0.85, class:^kitty|firefox$"
			# "opacity 1, title:.*( - YouTube).*$"
		];

		monitor = [ ", preferred, auto, auto" ];
		
		# env = [
		#	"HYPRCURSOR_THEME,"
		#	"HYPRCURSOR_SIZE,32"
		#	"XCURSOR_SIZE,32"
		#	"QT_QPA_PLATFORMTHEME,qt5ct"
		# ];

		misc = {
			force_default_wallpaper = 0;
		};
	};

	systemd.user.sessionVariables = {
		HYPRCURSOR_THEME = "rose-pine-hyprcursor";
		HYPRCURSOR_SIZE = "32";
		XCURSOR_SIZE = "32";
		QT_QPA_PLATFORMTHEME = "qt5ct";
		SOME_TEST = "hello";
	};
}
