vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true;
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.winborder = "rounded"
vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/altermo/ultimate-autopair.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require "mini.pick".setup({
	window = {
		config = {
			border = "rounded",
		}
	}
})

require "oil".setup({
	float = {
		max_height = .7,
		max_width = .7
	}
})

require "gitsigns".setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" }
	},
	signs_staged = {
		add = { text = "│" },
		change = { text = "│" }
	}
})

require "nvim-surround".setup({})
require "ultimate-autopair".setup({})

vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer" })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		vim.o.signcolumn = "yes";

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fr", ":Pick resume<CR>")
vim.keymap.set("n", "<leader>fs", ":Oil --float<CR>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')-- Lua

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
