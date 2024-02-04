return {
	-- Rose pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- Nvimgelion
	{
		"nyngwang/nvimgelion",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("nvimgelion")
		end,
	},

	-- Kanawaga theme
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = { bg_gutter = "none" },
						},
					},
					palette = {
						sumiInk3 = "#121217",
						sumiInk4 = "#1F1F28",
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					local diagnostics = "#595975"
					return {
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p1 },
						CmpDoc = { fg = theme.ui.shade0, bg = theme.ui.bg },
						CmpBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
						FloatBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
						DiagnosticVirtualTextHint = { fg = diagnostics },
						DiagnosticVirtualTextInfo = { fg = diagnostics },
						DiagnosticVirtualTextWarn = { fg = diagnostics },
						DiagnosticVirtualTextError = { fg = diagnostics },
					}
				end,
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
