return {
	{
		'neovim/nvim-lspconfig',
		event = { "BufNewFile", "BufReadPost" },
		dependencies = {
			'hrsh7th/cmp-nvim-lsp'
		},
		config = function()
			local lspconfig = require('lspconfig')

			local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

			local default_setup = {
				capabilities = default_capabilities
			}

			lspconfig.rust_analyzer.setup({
				capabilities = default_capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							runBuildScripts = true
						}
					}
				}
			})

			lspconfig.lua_ls.setup({
				capabilities = default_capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})

			lspconfig.nil_ls.setup(default_setup)
			lspconfig.vuels.setup(default_setup)
			lspconfig.pyright.setup(default_setup)
			lspconfig.emmet_ls.setup(default_setup)
			lspconfig.zls.setup(default_setup)
			lspconfig.ts_ls.setup(default_capabilities)
			lspconfig.jdtls.setup(default_capabilities)
		end
	},
	{ "mfussenegger/nvim-jdtls" }
}
