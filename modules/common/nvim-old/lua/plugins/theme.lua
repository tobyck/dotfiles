return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night";
			on_highlights = function(hl, c)
				for _, group in ipairs({
					"TelescopeNormal", "TelescopeBorder",
					"TelescopePromptNormal", "TelescopePromptBorder", "TelescopePromptTitle",
					"NormalFloat", "FloatBorder"
				}) do
					hl[group] = { bg = c.bg, fg = (hl[group] and hl[group].fg) or c.fg }
				end

				-- brighten line numbers
				-- local line_nr_colour = { fg = "#515A82" }
				-- hl.LineNr = line_nr_colour
				-- hl.LineNrAbove = line_nr_colour
				-- hl.LineNrBelow = line_nr_colour

				-- darken cursorline bg
				hl.CursorLine = { bg = "#24283b" }
			end
		}
	},
	{
		"f-person/auto-dark-mode.nvim",
		config = true,
		opts = {
			set_dark_mode = function()
				vim.cmd("colorscheme tokyonight-night")
				vim.opt.cursorline = true
			end,
			set_light_mode = function()
				vim.cmd("colorscheme tokyonight-day")
				vim.opt.cursorline = false
			end,
		}
	}
}
