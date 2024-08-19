{ pkgs, ... }:

{
	imports = [
		./terminal/kitty.nix
		./terminal/fish

		./programs/nvim
		./programs/firefox.nix
		./programs/cava.nix

		./services/kanata

		./sway
		./hypr
		./gtk.nix
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
		swaylock-fancy
		
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
		jq

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
		typst

		# Language servers
		# (Install rust-analyzer with rustup: `rustup component add rust-analyzer`)
		typescript-language-server
		lua-language-server
		nil # Nix
		# typst-lsp (this is causing a compiler error at the moment)
		nodePackages.vls # Vue
		pyright

		# Fonts
		inter
		ibm-plex
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

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.apple-cursor;
		name = "macOS-BigSur";
		size = 24;
	};
}
