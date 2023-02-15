-- Database manager
-- https://github.com/tpope/vim-dadbod

return {
    {
        'tpope/vim-dadbod',
        dependencies = {
            {
                'kristijanhusak/vim-dadbod-ui',
                config = function()
                    vim.g.dadbod_ui_auto_execute_table_helpers = 0
                end,
            }
        },
        keys = { { '<leader>sq', ':DBUIToggle<CR>', desc = '[SQ]L Database UI Toggle' } }
    }
}
