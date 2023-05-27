return {
    -- Git manager
    {
        "neogitorg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {},
        cmd = { "Neogit" },
        keys = {
            { "<leader>g", "<CMD>Neogit kind=vsplit<CR>", desc = "Neogit" }
        }
    },
    
    -- Git sign column (TODO: When Neogit implements signs, remove this)
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
        event = "BufRead"
    },
}
