{ pkgs, ... }:

{
	programs.ghostty = {
		enable = true;
		package = null;

		settings = {
			theme = "tokyonight_night";
			command = "${pkgs.fish}/bin/fish --login --interactive";
			shell-integration = "fish";
			font-family = "Iosevka NFM";
			font-size = 13.5;
			window-padding-x = 6;
			window-padding-y = 4;
		};
	};
}
