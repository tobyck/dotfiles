return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects'
		},
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
				'markdown',
				'arduino'
			},
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						['a='] = '@assignment.outer',
						['ilh'] = '@assignment.lhs',
						['irh'] = '@assignment.rhs',
						['abt'] = '@attribute.outer',
						['ibt'] = '@attribute.inner',
						['ak'] = '@block.outer',
						['ik'] = '@block.inner',
						['aca'] = '@call.outer',
						['ica'] = '@call.inner',
						['aco'] = '@comment.outer',
						['ico'] = '@comment.inner',
						['acn'] = '@conditional.outer',
						['icn'] = '@conditional.inner',
						['af'] = '@function.outer',
						['if'] = '@funciton.inner',
						['alp'] = '@loop.outer',
						['ilp'] = '@loop.inner',
						['in'] = '@number.inner',
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						['ar'] = '@return.outer',
						['ir'] = '@return.inner'
					}
				}
			}
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
	}
}
