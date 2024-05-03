{
	imports = [
		./main.nix
		./appearance.nix
		./binds.nix
		./gtk.nix
	];

	wayland.windowManager.hyprland.enable = true;
}
