return {
    -- Kanawara theme
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup {
                --transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = { bg_gutter = 'none' }
                        },
                    },
                    palette = {
                        sumiInk3 = '#121217',
                        sumiInk4 = '#1F1F28',
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
                        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p1 },
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
            vim.cmd.colorscheme('kanagawa')
        end,
    },

    -- Evangelion theme
    {
        'nyngwang/nvimgelion',
        config = true
    },

    -- Catppuccin theme
    {
        'catppuccin/nvim',
        opts = {
            flavour = 'mocha'
        }
    }
}
