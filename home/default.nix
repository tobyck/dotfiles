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
		
		# Terminal tools
		gh
		tree
		zoxide
		eza
		fzf
		ripgrep
		unzip
		nodePackages.sloc
		ffmpeg
		arduino-cli
		openssl

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		starship
		nitch
		bottom
		postman

		# Fonts
		inter
		(nerdfonts.override { fonts = [ "Iosevka" ]; })
	];

	programs.ags = {
		enable = true;
		configDir = ./ags;
	};

	home.shellAliases = {
		ls = "eza";
		la = "eza -a";
		ll = "eza -l --icons";

		md = "mkdir -p";
		rd = "rmdir";
	};
}
