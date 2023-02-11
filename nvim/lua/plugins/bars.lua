-- Navbar (bufferline) and statusbar (lualine)
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
            extensions = { 'nvim-tree', 'nvim-dap-ui', 'fugitive' }
        },
        event = 'VeryLazy',
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            options = {
                diagnostics = 'nvim_lsp',
            }
        },
        event = 'VeryLazy',
        keys = {
            { '<M-Right>', ':BufferLineCycleNext<CR>', desc = 'Next tab' },
            { '<M-Left>', ':BufferLineCyclePrev<CR>', desc = 'Previous tab' },
            { '<M-Up>', ':BufferLineMoveNext<CR>', desc = 'Move tab right' },
            { '<M-Down>', ':BufferLineMovePrev<CR>', desc = 'Move tab left' },
            { '<leader>ts', ':BufferLinePick<CR>', desc = 'Select tab' },
            { '<leader>tc', ':bd<CR>', desc = 'Close tab' },
            { '<leader>tC', ':BufferLinePickClose<CR>', desc = 'Pick tab and close' },
            { '<leader>td', ':%bd|e#|bd#<CR>', desc = 'Close all tabs but this one' },
            { '<leader>tD', ':%bd<CR>', desc = 'Close all tabs' },
            { '<leader>tp', ':BufferLineTogglePin<CR>', desc = 'Toggle tab pin' },
        }
    }
}
