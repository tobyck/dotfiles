{ pkgs, ... }:

{
	gtk = {
		enable = true;

		/* theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		}; */
		theme = {
			package = pkgs.tokyonight-gtk-theme.override {
				themeVariants = [ "default" ];
				tweakVariants = [ "outline" "float" ];
			};
			name = "Tokyonight-Dark";
		};
	};
}
