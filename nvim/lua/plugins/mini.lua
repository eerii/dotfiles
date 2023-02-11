-- Mini
-- https://github.com/echasnovski/mini.nvim
-- Tiny neovim modules

return {
    {
        'echasnovski/mini.pairs',
        config = function()
            require('mini.pairs').setup()
        end,
        event = 'InsertEnter'
    },
    {
        'echasnovski/mini.surround',
        config = function()
            require('mini.surround').setup()
        end,
        keys = { 'sa', 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' }
    },
    {
        'echasnovski/mini.comment',
        config = function()
            require('mini.comment').setup{
                mappings = {
                    comment = 'tc',
                    textobject = 'tc',
                    comment_line = 'tcc'
                }
            }
        end,
        keys = { 'tc', 'tcc' }
    },
    {
        'echasnovski/mini.align',
        config = function()
            require('mini.align').setup{
                mappings = {
                    start = 'ta',
                    start_with_preview = 'tA'
                }
            }
        end,
        keys = { 'ta', 'tA' }
    },
    {
        'echasnovski/mini.trailspace',
        config = function()
            require('mini.trailspace').setup()
        end,
        keys = { { 'tt', function() require('mini.trailspace').trim() end, desc = '[T]rim [T]railspace' } }
    }
}
