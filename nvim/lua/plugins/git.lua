-- Git utilities

return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "契" },
                topdelete = { text = "契" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local map = function(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map('n', ']h', gs.next_hunk, 'Git Next Hunk')
                map('n', '[h', gs.prev_hunk, 'Git Previous Hunk')

                map({ 'n', 'v' }, '<leader>gh', ':Gitsigns stage_hunk<CR>', '[G]it [H]unk [S]tage')
                map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', '[G]it [R]eset Hunk')

                map('n', '<leader>gS', gs.stage_buffer, '[G]it buffer [S]tage')
                map('n', '<leader>gu', gs.undo_stage_hunk, '[G]it [U]ndo Stage Hunk')
                map('n', '<leader>gd', gs.diffthis, '[G]it [D]iff')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git Select Hunk')

                map('n', '<leader>gt', gs.toggle_deleted, '[G]it [T]oggle Deleted')
                map('n', '<leader>gv', gs.preview_hunk_inline, '[G]it [V]iew Hunk')
            end,
        },
        event = { 'BufReadPre', 'BufNewFile' }
    },
}
