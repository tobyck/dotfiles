{
	programs.fish = {
		enable = true;

		interactiveShellInit = ''
			# Disable greeting
			set fish_greeting

			set -x PATH \
					$HOME/.nix-profile/bin \
					/etc/profiles/per-user/$USER/bin \
					/run/current-system/sw/bin \
					/nix/var/nix/profiles/default/bin \
					/usr/local/bin \
					/opt/homebrew/bin \
					~/.cargo/bin \
					~/.local/share/bob/nvim-bin \
					$PATH

			if command -q nix-your-shell
					nix-your-shell fish | source
			end

			functions --erase l

			set -e LS_COLORS

			# Use terminal colours for fzf
			set -x FZF_DEFAULT_OPTS "--color 16"

			# Initialise some stuff
			starship init fish | source
			zoxide init fish --cmd cd | source
		'';
	};
}
