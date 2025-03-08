{ pkgs, ... }:

{
	imports = [
		# (import ../common/terminal/emulators/kitty.nix { inherit pkgs; font = { name = "Iosevka Nerd Font Mono"; size = 13; }; padding = 6; })
		../common/terminal/emulators/ghostty.nix
		../common/terminal/shells/fish
		../common/terminal/tmux.nix

		../common/nvim
	];

	home.username = "toby";
	home.homeDirectory = "/Users/toby";

	home.packages = with pkgs; [
		gh
		tree
		zoxide
		fzf
		eza
		ripgrep
		nodePackages.sloc
		bottom
		lazygit
		starship
		vivid
		arduino-cli
		platformio
		nix-your-shell
		any-nix-shell
		nerd-fonts.iosevka
		gradle
	];

	home.shellAliases = {
		ls = "eza";
		la = "eza -a";
		ll = "eza -l --icons";
		lla = "eza -la --icons";

		md = "mkdir -p";
		rd = "rmdir";
	};

	programs.home-manager.enable = true;

	home.stateVersion = "24.05";
}
