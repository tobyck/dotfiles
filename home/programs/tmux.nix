{ pkgs, ... }:

# none of this works btw

{
	programs.tmux = {
		enable = true;
		keyMode = "vi";
		plugins = [
			{
				plugin = pkgs.tmuxPlugins.catppuccin;
				extraConfig = ''
set -g @catppuccin_status_background "#16161e"
set -g @catppuccin_window_status_style "rounded"
set -g @catppuccin_status_modules_left "session"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator ""
set -g @catppuccin_status_connect_separator "no"
				'';
			}
		];
	};
}
