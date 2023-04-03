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
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' }, right_padding = 2 },
                },
                lualine_b = {
                    { 'filename' },
                },
                lualine_c = {
                    { 'diagnostics', sources = { 'nvim_lsp' } }
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
                    { 'location', separator = { right = '' } },
                },
            },
            extensions = { 'nvim-tree', 'nvim-dap-ui', 'fugitive' }
        },
        event = 'VeryLazy',
    },
}
