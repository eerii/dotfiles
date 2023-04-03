-- Navbar (bufferline) and statusbar (lualine)
-- https://github.com/hoob3rt/lualine.nvim

return {
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
