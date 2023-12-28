return {
	-- Pywal automatic theme
	{
		"sprockmonty/wal.vim",
		dir = "~/Code/pkgs/nvim-plugin/wal.vim",
		enabled = false,
		--lazy = false,
		--priority = 1000,
		config = function()
			vim.cmd("colorscheme wal")
		end,
	},

	-- Catppuccin theme
	{
		"catppuccin/nvim",
		enabled = false,
		--lazy = false,
		--priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},

	-- Rose pine theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		--lazy = false,
		--priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},

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
					return {
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p1 },
						CmpDoc = { fg = theme.ui.shade0, bg = theme.ui.bg },
						CmpBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
						TelescopeTitle = { fg = theme.syn.identifier, bold = true },
						TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
						FloatBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
					}
				end,
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- Evangelion theme
	{
		"nyngwang/nvimgelion",
		enabled = false,
		--lazy = false,
		--priority = 1000,
		config = true,
	},
}
