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
		hypridle
		hyprlock
		
		# Terminal commands/tools
		gh
		tree
		zoxide
		ripgrep

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

	programs.bash.enable = true;
}
