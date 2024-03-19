return {
    -- git sign column
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "│" },
                untracked = { text = "│" },
            },
        },
        event = "BufRead",
        keys = {
            { "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>",          mode = { "n", "v" },       desc = "Git stage hunk" },
            { "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>",          mode = { "n", "v" },       desc = "Git reset hunk" },
            { "<leader>gS", "<CMD>Gitsigns stage_buffer<CR>",        desc = "Git stage buffer" },
            { "<leader>gR", "<CMD>Gitsigns reset_buffer<CR>",        desc = "Git reset buffer" },
            { "<leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>",     desc = "Git undo stage" },
            { "<leader>gp", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Git preview" },
            { "<leader>gd", "<CMD>Gitsigns diffthis<CR>",            desc = "Git diff" },
            { "<leader>gt", "<CMD>Gitsigns toggle_deleted<CR>",      desc = "Git toggle delete" },
            {
                "<leader>gb",
                function()
                    require("gitsigns").blame_line({ full = true })
                end,
                desc = "Git blame line",
            },
            { "ih", "<CMD>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Git select hunk" },
        },
    },

    -- github
    {
        "pwntester/octo.nvim",
        opts = {},
        cmd = { "Octo" },
    },
}
