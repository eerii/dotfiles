return {
    -- Treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- Provides a set of configurations and tools to work with treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            -- Refactoring
            'nvim-treesitter/nvim-treesitter-refactor',
            -- Show named scopes
            {
                'nvim-treesitter/nvim-treesitter-context',
                config = true
            },
            -- Headlines for markdown
            {
                'lukas-reineke/headlines.nvim',
                config = function()
                    require('headlines').setup({
                        markdown = {
                            dash_string = "—",
                            fat_headline_upper_string = "▄",
                            fat_headline_lower_string = "▀",
                        },
                        rmd = {
                            dash_string = "—",
                            fat_headline_upper_string = "▄",
                            fat_headline_lower_string = "▀",
                        }
                    })

                    vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
                    vim.cmd [[highlight Dash guifg=#D19A66 gui=bold]]
                end,
                ft = { "markdown", "rmd" }
            }
        },
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'cpp', 'rust', 'python', 'lua', 'vim', 'vimdoc', 'query' },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                refactor = {
                    highlight_definitions = { enable = true },
                    smart_rename = { enable = true },
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_definition_lsp_fallback = "gld",
                            list_definitions = false,
                            list_definitions_toc = false,
                            goto_next_usage = "gtn",
                            goto_previous_usage = "gtp",
                        },
                    },
                },
            }
        end,
        event = 'BufReadPre',
    }
}
