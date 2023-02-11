-- Navbar and statusbar (lualine)
-- https://github.com/hoob3rt/lualine.nvim

return {
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
                    { 'diff', colored = true, symbols = { added = ' ', modified = '柳', removed = ' ' } },
                },
                lualine_z = {
                    { 'location', separator = { right = '' } },
                },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        'buffers',
                        symbols = { alternate_file = '' },
                        separator = { right = '' },
                        buffers_color = {
                            active = 'lualine_a_normal',
                            inactive = 'lualine_a_inactive',
                        },
                    }
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { 'nvim-tree', 'nvim-dap-ui', 'fugitive' }
        },
        event = 'VeryLazy',
    },
}
