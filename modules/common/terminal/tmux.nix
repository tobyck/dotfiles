{ pkgs, ... }:

{
  programs.tmux = rec {
    enable = true;
    shortcut = "s";
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
					set -g @resurrect-save 'S'
					set -g @resurrect-restore 'R'
				'';
      }
      tmuxPlugins.continuum
    ];
    extraConfig = ''
			set -g renumber-windows on
			set -g status-justify absolute-centre

			bind C-${shortcut} last-window

			set -g @status-bg '#1c1c1c'
			set -g @hl-bg '#363636'

			set -g status-left '#[bg=#{?client_prefix,default,#{@hl-bg}}] #S '
			set -g status-left-length 50
			set -g status-right '%a %-d %b %-I:%M %p '
			setw -g window-status-current-format '#I:#W '

			set -g mode-style 'bg=#{@hl-bg}'
			set -g status-style 'bg=#{@status-bg} fg=grey'
			set -g message-style 'bg=#{@status-bg}'
			setw -g window-status-current-style 'fg=blue bold'
			setw -g window-status-style 'fg=brightblack'
		'';
  };
}
