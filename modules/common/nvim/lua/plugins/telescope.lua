return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			'debugloop/telescope-undo.nvim'
		},
		keys = function()
			local telescope = require('telescope')
			local builtin = require('telescope.builtin')

			return {
				{ '<leader>ff', builtin.find_files },
				{ '<leader>fg', builtin.live_grep },
				{ '<leader>fb', builtin.buffers },
				{ '<leader>fs', telescope.extensions.file_browser.file_browser },
				{ '<leader>fr', builtin.resume },
				{ '<leader>u',  '<cmd>Telescope undo<CR>' }
			}
		end,
		config = function()
			local telescope = require('telescope')
			local fb_actions = telescope.extensions.file_browser.actions

			telescope.setup({
				extensions = {
					file_browser = {
						layout_config = {
							preview_width = 0.5
						},
						mappings = {
							["i"] = {
								-- alt+letter gives you symbols on macos
								["<C-A-c>"] = fb_actions.create,
								["<C-A-r>"] = fb_actions.rename,
								["<C-A-m>"] = fb_actions.move,
								["<C-A-y>"] = fb_actions.copy,
								["<C-A-d>"] = fb_actions.remove
							}
						}
					}
				}
			})

			telescope.load_extension('file_browser')
			telescope.load_extension('undo')
		end
	}
}
