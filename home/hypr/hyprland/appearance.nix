{ pkgs, ... }:

{
	wayland.windowManager.hyprland.settings = {
		general = {
			gaps_in = 4;
			gaps_out = 8;
			border_size = 2;

			"col.active_border" = "$iris $foam 45deg";
			"col.inactive_border" = "$muted"; # Grey
		};

		decoration = {
			rounding = 6;

			# Default shadow
			drop_shadow = true;
			shadow_range = 4;
			shadow_render_power = 3;
			"col.shadow" = "rgba(1a1a1aee)";
		};

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

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.apple-cursor;
		name = "macOS-Monterey";
		size = 22;
	};
}
