return {
    {
        'glepnir/dashboard-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = 'hyper',
            shortcut_type = 'number',
            change_to_vcs_root = true,
            config = {
                week_header = {
                    enable = true,
                    concat = 'koala'
                },
                shortcut = {
                    {
                        icon = 'ﮮ ',
                        desc = 'Update',
                        group = '@property',
                        action = 'Lazy update',
                        key = 'u'
                    },
                }
            }
        },
        keys = { { '<leader>s', ':Dashboard<CR>', 'Open [S]tart screen' } },
        event = 'VimEnter',
        enabled = false,
    }
}
