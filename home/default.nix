{ pkgs, ... }:

{
	imports = [
		./terminal/kitty.nix
		./terminal/fish

		./programs/nvim
		./programs/firefox.nix

		./services/kanata

		./hypr
	];

	home = {
		username = "toby";
		homeDirectory = "/home/toby";
		stateVersion = "23.11";
	};

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
		# Desktop
		swaybg
		
		# Terminal commands/tools
		tree
		zoxide
		gh

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		starship
		nitch
		bottom

		# Fonts
		inter
		(nerdfonts.override { fonts = [ "Iosevka" ]; })
	];
}
