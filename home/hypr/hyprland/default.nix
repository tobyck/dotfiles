{
	imports = [
		./main.nix
		./appearance.nix
		./binds.nix
	];

	wayland.windowManager.hyprland.enable = true;
}
