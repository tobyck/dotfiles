return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			'debugloop/telescope-undo.nvim'
		},
		config = function()
			local telescope = require('telescope')
			local builtin = require('telescope.builtin')

			require("telescope").setup({
				extensions = {
					file_browser = {
						layout_config = {
							preview_width = 0.5
						}
					}
				}
			})

			telescope.load_extension('file_browser')
			telescope.load_extension('undo')

			-- keybinds
			vim.keymap.set('n', '<leader>ff', builtin.find_files)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep)
			vim.keymap.set('n', '<leader>fb', builtin.buffers)
			vim.keymap.set('n', '<leader>fs', telescope.extensions.file_browser.file_browser)
			vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<CR>')
		end
	}
}
