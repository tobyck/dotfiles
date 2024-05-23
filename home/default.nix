{ pkgs, ... }:

{
	imports = [
		./terminal/kitty.nix
		./terminal/fish

		./programs/nvim

		./services/kanata

		./hypr
	];

	home = {
		username = "toby";
		homeDirectory = "/home/toby";
		stateVersion = "23.11";
	};

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			sansSerif = [ "Inter" ];
		};
	};

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
		mosquitto

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		firefox
		starship
		nitch
		bottom
		postman
		hyprpicker

		# Fonts
		inter
		(nerdfonts.override { fonts = [ "Iosevka" ]; })
	];

	programs.ags = {
		enable = false;
		configDir = ./ags;
	};

	home.shellAliases = {
		ls = "eza";
		la = "eza -a";
		ll = "eza -l --icons";
		lla = "eza -la --icons";

		md = "mkdir -p";
		rd = "rmdir";
	};
}
