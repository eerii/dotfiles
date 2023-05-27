return {
    -- Show git diff in the sign column
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

                map('n', ']h', gs.next_hunk, 'Git next hunk')
                map('n', '[h', gs.prev_hunk, 'Git previous hunk')

                map({ 'n', 'v' }, '<leader>gsh', gs.stage_hunk, '[G]it [S]tage [H]unk')
                map({ 'n', 'v' }, '<leader>gr', gs.reset_hunk, '[G]it [R]eset hunk')
                map('n', '<leader>gu', gs.undo_stage_hunk, '[G]it [U]ndo stage hunk')

                map('n', '<leader>gsb', gs.stage_buffer, '[G]it [S]tage [B]uffer')
                map('n', '<leader>gd', gs.diffthis, '[G]it [D]iff')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git select hunk')

                map('n', '<leader>gt', gs.toggle_deleted, '[G]it [T]oggle deleted')
                map('n', '<leader>gv', gs.preview_hunk_inline, '[G]it [V]iew hunk')
            end,
        },
        event = { 'BufReadPre', 'BufNewFile' }
    },
}
