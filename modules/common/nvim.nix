{ pkgs, ... }:

{
	# Neovim is now managed by Bob
	# programs.neovim = {
	# 	enable = true;
	# 	viAlias = true;
	# 	vimAlias = true;
	# 	defaultEditor = true;
	# };

	home.file.".config/nvim" = {
		source = ./nvim;
		recursive = true;
	};

	# Install language servers
	home.packages = with pkgs; [
		# (Install rust-analyzer with rustup: `rustup component add rust-analyzer`)
		typescript-language-server
		lua-language-server
		nil # Nix
		vue-language-server
		pyright
		emmet-ls
		zls
		jdt-language-server
	];
}
