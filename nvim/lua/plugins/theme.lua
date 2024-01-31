return {
	-- Kanawaga theme
	{
		"rebelot/kanagawa.nvim",
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
						-- TelescopeTitle = { fg = theme.syn.identifier, bold = true },
						-- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						-- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						-- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						-- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						-- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						-- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
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
