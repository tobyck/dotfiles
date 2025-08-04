{ pkgs, ... }:

{
	programs.tmux = {
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
			set -g status-style 'fg=color7 bg=#1c1c1c'
			set -g message-style 'bg=default, fg=white'
			set -g status-left '#[bg=#{?client_prefix,default,#404040}] #S '
			set -g status-left-length 50
			set -g status-right '#[bg=#404040] %a %-d %b %-I:%M %p '
			setw -g window-status-current-style 'fg=colour6 bg=default bold'
			setw -g window-status-current-format '#I:#W '
			setw -g window-status-style 'fg=color8'
		'';
	};
}
