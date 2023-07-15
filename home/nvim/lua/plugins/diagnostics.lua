return {
    -- Trouble (diagnostics list)
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "bottom"
        },
        keys = {
            { "<leader>ld", "<CMD>TroubleToggle document_diagnostics<CR>", desc = "Trouble document diagnostics" },
            { "<leader>lD", "<CMD>TroubleToggle workspace_diagnostics<CR>", desc = "Trouble workspace diagnostics" },
            { "<leader>lq", "<CMD>TroubleToggle quickfix<CR>", desc = "Trouble quickfix" },
            -- TODO: Add LSP lists
        }
    },

    -- Todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = { 
            { "<leader>lt", "<CMD>TodoTelescope<CR>", desc = "Todo list on Telescope" },
            { "<leader>lT", "<CMD>TodoTrouble<CR>", desc = "Todo list on Trouble" },
        },
        event = "BufRead"
    }
}
