vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true;
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true -- doesn't work?
vim.o.winborder = "rounded"
vim.o.spell = true
vim.g.mapleader = " "
vim.g.copilot_filetypes = { ["*"] = false }

vim.cmd("setglobal expandtab")

vim.pack.add({
	{ src = "https://github.com/EdenEast/nightfox.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/altermo/ultimate-autopair.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
	},
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/ARM9/arm-syntax-vim" },
})

-- colour
vim.cmd("colorscheme carbonfox")
vim.cmd(":hi statuslinenc guibg=default")
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

local harpoon = require "harpoon":setup()
local harpoon_ui_opts = {
	border = "rounded",
}

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup({
	ensure_installed = { "typescript", "c", "cpp", "rust", "lua", "nix", "typst", "proto", "comment", "python" },
	highlight = { enable = true },
	indent = { enable = true },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['aca'] = '@call.outer',
				['ica'] = '@call.inner',
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

vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer", "nil_ls", "jdtls", "tinymist" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
		semanticTokens = "disable"
	}
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				enable = true,
			}
		}
	}
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.o.signcolumn = "yes";

		-- make auto complete show up when you type
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect,menuone")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.s", "*.S" },
	callback = function()
		vim.cmd("setlocal nospell")
		vim.bo.commentstring = "// %s"
		vim.cmd("set ft=arm")
	end,
})

-- keybinds

vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>fr", ":FzfLua resume<CR>")
vim.keymap.set("n", "<leader>fs", ":Oil<CR>")

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>dw", vim.diagnostic.setqflist)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>s", "1z=")

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list(), harpoon_ui_opts) end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>e", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>i", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>o", function() harpoon:list():select(4) end)
