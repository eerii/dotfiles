return {
    -- Toggle terminal
    {
        'akinsho/toggleterm.nvim',
        opts = {
            open_mapping = [[<C-t>]],
            start_in_insert = true,
            insert_mappings = true,
            direction = 'vertical',
            size = 50
        },
        event = 'VeryLazy',
    }
}
