{ pkgs, ... }:

{
	imports = [
		../common/terminal/emulators/ghostty.nix
		../common/terminal/shells/fish
		../common/terminal/tmux.nix

		../common/nvim.nix
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
		arduino-cli
		platformio
		nix-your-shell
		any-nix-shell
		nerd-fonts.iosevka
		gradle
		utm
	];

	home.shellAliases = {
		ls = "eza";
		tree = "tree -C";
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;

	home.stateVersion = "24.05";
}
