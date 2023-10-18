return {
    -- Pywal automatic theme
    {
        "sprockmonty/wal.vim",
        dir = "~/Code/pkgs/nvim-plugin/wal.vim",
        enabled = false,
        lazy = false,
        priority = 1000,
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
			require("catppuccin").setup {
				flavour = "mocha"
			}
			vim.cmd("colorscheme catppuccin")
		end,
    },

    -- Rose pine theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
	    lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup {
				disable_background = true
			}
			vim.cmd("colorscheme rose-pine")
		end,
	},

    -- Kanawaga theme
    {
        "rebelot/kanagawa.nvim",
        enabled = false,
        --lazy = false,
        --priority = 1000,
        config = function()
            require("kanagawa").setup {
                --transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = { bg_gutter = "none" }
                        },
                    },
                    palette = {
                        sumiInk3 = "#121217",
                        sumiInk4 = "#1F1F28",
                    }
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
                        TelescopePromptBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
                        TelescopeResultsBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
                        TelescopePreviewBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
                        FloatBorder = { fg = theme.syn.keyword, bg = theme.ui.bg },
                    }
                end,
            }
            vim.cmd.colorscheme("kanagawa")
        end,
    },

    -- Evangelion theme
    {
        "nyngwang/nvimgelion",
        enabled = false,
        --lazy = false,
        --priority = 1000,
        config = true
    },
}
