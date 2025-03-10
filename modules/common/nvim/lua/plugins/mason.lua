return {
	--[[ {
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim"
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"vuels",
					"emmet_ls",
					"zls", -- zig
					"jdtls" -- java :(
				}
			})
		end
	} ]]
}
