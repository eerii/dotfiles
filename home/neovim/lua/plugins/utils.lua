return {
    -- autosave files
    {
        "okuuva/auto-save.nvim",
        opts = {
            debounce_delay = 1000,
            execution_message = {
                enabled = false,
            },
            condition = function(buf)
                local fn = vim.fn
                return fn.getbufvar(buf, "&buftype") == ""
            end,
        },
        event = { "InsertLeave", "TextChanged" },
        keys = {
            { "<leader>ts", "<CMD>ASToggle<CR>", desc = "Toggle auto-save" },
        },
    },

    -- file explorer
    {
        "echasnovski/mini.files",
        version = false,
        opts = {
            mappings = {
                close = "<ESC>",
                go_in_plus = "<CR>",
            },
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 30,
            },
            options = {
                permanent_delete = false,
                use_as_default_explorer = true,
            },
        },
        keys = {
            {
                "<leader>sa",
                function()
                    require("mini.files").open()
                end,
                desc = "Open [F]iles",
            },
        },
    },

    -- navigate between panes and multiplexers
    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
    },
}
