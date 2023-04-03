return {
    -- Toggle comments
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

    -- Align text
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

    -- Trim trailspace
    {
        'echasnovski/mini.trailspace',
        config = function()
            require('mini.trailspace').setup()
        end,
        keys = { { 'tt', function() require('mini.trailspace').trim() end, desc = '[T]rim [T]railspace' } }
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        config = true,
        event = "InsertEnter",
    },

    -- Change surrounding pairs
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'ts',
                delete = 'tS',
                find = 'tf',
                find_left = 'tF',
                highlight = 'th',
                replace = 'tr',
                update_n_lines = '',
                suffix_last = 'l',
                suffix_next = 'n',
            },
        },
        keys = { 'ts', 'tS', 'tf', 'tF', 'th', 'tr' }
    },

    -- TODO: Multiple cursors
    --[[ {
        'mg979/vim-visual-multi',
        config = function()
            vim.g.VM_default_mappings = false
        end,
        branch = 'master',
        event = 'BufRead',
    } ]]--
}
