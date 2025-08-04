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
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/altermo/ultimate-autopair.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/github/copilot.vim" },
})

-- colour
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=#1c1c1c")

-- simple plugins
require "fzf-lua".setup()
require "ultimate-autopair".setup()
require "nvim-surround".setup()

-- plugin configs

require "oil".setup({
	float = {
		max_width = 0.8,
		max_height = 0.85,
	}
})

require "nvim-treesitter.configs".setup({
	ensure_installed = { "typescript", "c", "cpp", "rust", "lua", "nix" },
	highlight = { enable = true },
	indent = { enable = true },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['aca'] = '@call.outer',
				['ica'] = '@call.inner',
				['acm'] = '@comment.outer',
				['icm'] = '@comment.inner',
				['af'] = '@function.outer',
				['if'] = '@funciton.inner',
				['in'] = '@number.inner',
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['art'] = '@return.outer',
				['irt'] = '@return.inner'
			}
		}
	}
})

-- lsp stuff

vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer", "nil_ls" })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		vim.o.signcolumn = "yes";

		-- make auto complete show up when you type
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")

-- keybinds

vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", ":FzfLua grep_project<CR>")
vim.keymap.set("n", "<leader>fr", ":FzfLua resume<CR>")
vim.keymap.set("n", "<leader>fs", ":Oil<CR>")

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", ":FzfLua lsp_code_actions<CR>")
vim.keymap.set("n", "<leader>rr", ":FzfLua lsp_references<CR>")
vim.keymap.set("n", "<leader>fd", ":FzfLua lsp_workspace_diagnostics<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
