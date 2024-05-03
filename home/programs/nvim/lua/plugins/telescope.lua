return {
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local telescope = require('telescope')
			local builtin = require('telescope.builtin')
			local actions = require('telescope.actions')

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							['<C-l>'] = actions.move_selection_previous,
							['<C-n>'] = actions.move_selection_next
						}
					}
				},
				extensions = {
					file_browser = {
						layout_config = {
							preview_width = 0.5
						}
					}
				}
			})

			telescope.load_extension('file_browser')

			-- keybinds
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fs', telescope.extensions.file_browser.file_browser, {})
		end
	}
}
