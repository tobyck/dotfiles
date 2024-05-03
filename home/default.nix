{ pkgs, ... }:

{
	imports = [
		./hypr
	];

	home = {
		username = "toby";
		homeDirectory = "/home/toby";
		stateVersion = "23.11";
	};

	home.packages = with pkgs; [
		# Desktop
		swaybg
		
		# Terminal commands/tools
		tree
		gh

		# TEMP (will move to seperate config files soon)
		firefox
		kitty
		vim
	];
}
