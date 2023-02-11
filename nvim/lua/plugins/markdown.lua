-- Markdown support

return {
    {
        'adalessa/markdown-preview.nvim', -- Preview in pdf (TODO: fork locally and fix)
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = true,
        ft = 'markdown',
        keys = { { '<leader>md', ':MarkdownPreviewToggle<CR>', desc = '[M]ark[d]own preview toggle' } },
        enable = false
    },
    {
        'ellisonleao/glow.nvim', -- Preview right in CMD (not working right now)
        config = true,
        cmd = 'Glow',
        enable = false
    },
    {
        'jakewvincent/mkdnflow.nvim',
        opts = {
            mappings = {
                MkdnEnter = {{'i', 'n', 'v'}, '<C-CR>'},
                MkdnNextLink = false,
                MkdnPrevLink = false,
                MkdnTableNextCell = false,
                MkdnTablePrevCell = false,
            }
        },
        ft = 'markdown',
    }
}
