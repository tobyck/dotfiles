{ pkgs, font, padding, ... }:

{
	programs.kitty = {
		enable = true;
		themeFile = "tokyo_night_night";
		font = font;
		shellIntegration.enableFishIntegration = true;
		settings = {
			window_padding_width = padding;
			cursor_blink_interval = 0;
			cursor_underline_thickness = 1;
			allow_remote_control = "yes";
			shell = "${pkgs.fish}/bin/fish --login --interactive";
		};
	};
}
