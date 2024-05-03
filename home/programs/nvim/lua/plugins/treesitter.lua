return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'javascript',
				'typescript',
				'html',
				'css',
				'c',
				'cpp',
				'rust',
				'java',
				'kotlin',
				'nix',
				'lua',
				'json',
				'markdown'
			},
			highlight = { enable = true },
			indent = { enable = true }
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end
	}
}
