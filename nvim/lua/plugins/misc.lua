-- Misc
-- Plugins that don't fit elsewhere

return {
    -- Keymaps
     {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('which-key').setup()
        end,
        event = 'VeryLazy'
    },

    -- Load local neovim configuration
    {
        'klen/nvim-config-local',
        opts = {
            config_files = { '.nvim.lua' }
        },
        event = 'VimEnter'
    },

    -- Vim games
    {
        'theprimeagen/vim-be-good',
        cmd = 'VimBeGood'
    }
}
