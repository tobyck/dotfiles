{ pkgs, ... }:

{
	imports = [
		../common/terminal/kitty.nix
		../common/terminal/nushell.nix

		../common/nvim
		../common/firefox.nix
		../common/cava.nix
		../common/tmux.nix

		./services/kanata.nix

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
		pandoc
		vivid

		# TUIs
		bottom
		lazygit

		# GUIs
		postman
		(obsidian.overrideAttrs (oldAttrs: rec {
			desktopItem = oldAttrs.desktopItem.override (oldDesktopItem: {
				exec = "${oldDesktopItem.exec} --ozone-platform-hint=auto";
			});
			installPhase = builtins.replaceStrings
				[ "${oldAttrs.desktopItem}" ]
				[ "${desktopItem}" ]
				oldAttrs.installPhase;
		}))
		nautilus
		deja-dup

		# Screen capture
		grim
		slurp
		swappy
		wf-recorder

		# Misc
		starship
		nitch
		hyprpicker

		# Language servers
		# (Install rust-analyzer with rustup: `rustup component add rust-analyzer`)
		typescript-language-server
		lua-language-server
		nil # Nix
		nodePackages.vls # Vue
		pyright
		emmet-ls

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
	};

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.apple-cursor;
		name = "macOS";
		size = 20;
	};
}
