return {
    -- move lines up/down
    {
        "echasnovski/mini.move",
        version = false,
        opts = {
            mappings = {
                -- move visual selection in Visual mode
                down = "J",
                up = "K",
                left = "H",
                right = "L",

                -- move current line in Normal mode
                line_down = "J",
                line_up = "K",
                line_left = "H",
                line_right = "L",
            },
        },
        keys = {
            "J", "K", "H", "L"
        },
    },

    -- better jump and search
    {
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {
            label = {
                uppercase = false,
                rainbow = {
                    enabled = true,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
            "/", "t", "f", "T", "F"
        },
    }
}
