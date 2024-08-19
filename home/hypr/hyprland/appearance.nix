{ pkgs, ... }:

{
	wayland.windowManager.hyprland.settings = let
	  border = true;
	in {
		general = {
			gaps_in = 4;
			gaps_out = 8;
			border_size = if border then 1 else 0;

			"col.active_border" = "rgb(a9b1d6)";
			"col.inactive_border" = "rgb(565f89)";
		};

		decoration = {
			rounding = 6; # if border then 6 else 0;

			# Default shadow
			drop_shadow = border;
			shadow_range = 4;
			shadow_render_power = 3;
			"col.shadow" = "rgba(202020dd)";
		};

		windowrulev2 = [
			# "opacity 0.92, class:^kitty|firefox$"
			# "opacity 1, title:.*( - YouTube).*$"
		];

		animations = {
			enabled = true;

			# Default animations but sped up a bit
			bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

			animation = [
				"windows, 1, 5, myBezier"
				"windowsOut, 1, 5, default, popin 80%"
				"border, 1, 10, default"
				"borderangle, 1, 8, default"
				"fade, 1, 5, default"
				"workspaces, 1, 5, default"
			];
		};
	};
}
