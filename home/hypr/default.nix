{
	imports = [ ./hyprland ];

	home.file = {
		".config/hypr/hypridle.conf".source = ./hypridle.conf;

		".config/hypr/hyprlock.conf".text = (builtins.readFile ./hyprlock.conf) + ''
			label {
				monitor =

				text = cmd[update:2000] ${./scripts/lockscreen-battery.sh}
				font_size = 18
				font_family = Iosevka NF ExtraBold

				position = 0, 60
				halign = center
				valign = bottom
			}
		'';
	};
}
