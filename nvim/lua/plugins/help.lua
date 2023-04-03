return {
    -- Keymaps
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
            require('which-key').setup()
        end,
        event = 'VeryLazy'
    },

    -- Vim games
    {
        'theprimeagen/vim-be-good',
        cmd = 'VimBeGood'
    },

    -- Treesitter playground
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle'
    },
}
