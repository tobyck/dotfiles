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
		
		# Terminal tools/CLIs
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
		mosquitto
		surge-cli
		cargo-flamegraph
		bc

		# TUIs
		bottom
		lazygit

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		starship
		nitch
		postman
		hyprpicker

		# Language servers
		# (Install rust-analyzer with rustup: `rustup component add rust-analyzer`)
		nodePackages.typescript-language-server
		lua-language-server
		nil # For Nix

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
		lla = "eza -la --icons";

		md = "mkdir -p";
		rd = "rmdir";

		notes = "$EDITOR ~/Documents/notes.md";
	};
}
