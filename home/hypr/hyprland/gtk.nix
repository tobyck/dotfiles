{ config, pkgs, ... }:

{
	gtk = {
		enable = true;

		theme = {
			name = "Tokyonight-Dark-BL";
			package = pkgs.tokyonight-gtk-theme;
		};
	};

	# Symlink some stuff to make it work with gtk 4
	xdg.configFile = {
		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};
}
