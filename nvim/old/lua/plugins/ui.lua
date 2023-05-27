return {
    -- Zen mode
    {
        'folke/zen-mode.nvim',
        dependencies = {
            -- Dim inactive regions
            {
                'folke/twilight.nvim',
                config = true,
            }
        },
        config = true,
        keys = {
            { '<leader>z', ':ZenMode<CR>', desc = 'Enable [Z]en Mode' }
        },
    },
    -- Lualine status bar
    {
        'hoob3rt/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            options = {
                theme = 'kanagawa',
                component_separators = ' ',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' } },
                },
                lualine_b = {
                    { 'filename' },
                },
                lualine_c = {
                    { 'diagnostics', sources = { 'nvim_lsp' } },
                    { 'navic' }
                },
                lualine_x = {
                    { 'encoding', colored = true },
                    { 'filetype', colored = true },
                },
                lualine_y = {
                    { 'branch', icon = '' },
                    { 'diff',   colored = true, symbols = { added = ' ', modified = '柳', removed = ' ' } },
                },
                lualine_z = {
                    { 'location', separator = { right = '' } },
                },
            },
            extensions = {}
        },
        event = 'VeryLazy',
    },
    -- Notifications
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                background_colour = '#040c1a',
                timeout = 2000
            }
            vim.notify = require('notify').notify
            require('telescope').load_extension('notify')
        end,
        event = 'VeryLazy'
    },
    -- Better commandline
    -- TODO: Change to noice when the issue with neovide is resolved
    {
        'vonheikemen/fine-cmdline.nvim',
        dependencies = {
            'muniftanjim/nui.nvim'
        },
        opts = {
            popup = {
                relative = "editor",
            }
        },
        keys = {
            { ':', ':FineCmdline<CR>', desc = 'Cmdline' },
        },
    },
    {
        'folke/noice.nvim',
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            'muniftanjim/nui.nvim'
        },
        enabled = false
    }
}
