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
		eza
		fzf
		ripgrep
		unzip

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		starship
		nitch
		bottom
		ffmpeg

		# Fonts
		inter
		(nerdfonts.override { fonts = [ "Iosevka" ]; })
	];

	home.shellAliases = {
		ls = "eza";
		la = "eza -a";
		ll = "eza -l --icons";

		md = "mkdir -p";
		rd = "rmdir";
	};
}
