{ pkgs, ... }:

{
	programs.tmux = let
		dark-mode-colours = pkgs.writeText "dark-mode.tmux" ''
			set -g @alt_blue '#3b4261'
			set -g @status_bg black
			set -g @inactive_win_bg1 '#1f2233'
			set -g @inactive_win_bg2 '#292e42'
			set -g mode-style 'bg=#283457'
		'';
		light-mode-colours = pkgs.writeText "light-mode.tmux" ''
			set -g @alt_blue '#a9aec9'
			set -g @status_bg '#d1d5e2'
			set -g @inactive_win_bg1 '#c3c6d8' # bg of win name text
			set -g @inactive_win_bg2 '#b4b8d0' # bg of win number
			set -g mode-style 'bg=#b9c1e0'
		'';
		switcher-script = pkgs.writeShellScript "tmux-theme-switcher" ''
			if [ "$DARKMODE" == "1" ]; then
				tmux source-file ${dark-mode-colours}
			fi

			if [ "$DARKMODE" == "0" ]; then
				tmux source-file ${light-mode-colours}
			fi
		'';
		init-script-name = "tmux-theme-switcher-init";
		init-script = pkgs.writeShellScript init-script-name ''
			pkill -f ${init-script-name}
			dark-mode-notify ${switcher-script}
		'';
	in {
		enable = true;
		shortcut = "s";
		keyMode = "vi";
		mouse = true;
		shell = "${pkgs.fish}/bin/fish";
		terminal = "xterm-ghostty";
		plugins = with pkgs; [
			tmuxPlugins.vim-tmux-navigator
		];
		extraConfig = ''
			set -g status-justify centre
			set -g status-style 'fg=color7 bg=default'
			set -g status-left '#S'
			set -g status-left-length 50
			set -g status-right '%a %-d %b %-I:%M %p '
			setw -g window-status-current-style 'fg=colour6 bg=default bold'
			setw -g window-status-current-format '#I:#W '
			setw -g window-status-style 'fg=color8'

			# ADD $'s !!!
			# {if pkgs.system == "linux" 
			#  		then dark-mode-colours 
			#  		else "run \"bash -c '{init-script} >/dev/null 2>&1 &'\""}

			# set -g message-style 'bg=#{@status_bg}, fg=white'
			# set -g status-justify centre
			# set -g status-style 'bg=#{@status_bg}'

			# setw -g window-status-current-format '#[bg=#{@status_bg}, fg=blue]#[bg=blue, fg=black] #I #[bg=#{@alt_blue}, fg=blue] #W #[bg=#{@status_bg}, fg=#{@alt_blue}]'
			# setw -g window-status-format '#[bg=#{@status_bg} fg=#{@inactive_win_bg2}]#[bg=#{@inactive_win_bg2}, fg=white] #I #[bg=#{@inactive_win_bg1} fg=#{@inactive_win_bg2}]#[bg=#{@inactive_win_bg1}, fg=white] #W #[bg=#{@status_bg}, fg=#{@inactive_win_bg1}]'
			# setw -g window-status-separator ' '

			# set -g status-left-length 50
			# set -g status-left '#[bg=#{?client_prefix,magenta,blue}, fg=black] #S #[bg=#{@status_bg}, fg=#{?client_prefix,magenta,blue}]'
			# set -g status-right '#[bg=#{@status_bg}, fg=#{@alt_blue}]#[bg=#{@alt_blue}, fg=blue] %a %b %-d #[bg=blue, fg=black] %-I:%M %p '
		'';
	};
}
