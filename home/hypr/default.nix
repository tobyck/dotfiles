{
	imports = [ ./hyprland ];

	home.file = {
		".config/hypr/hypridle.conf".source = ./hypridle.conf;
		".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
	};
}
