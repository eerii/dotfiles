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
            "J",
            "K",
            "H",
            "L",
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
    },

    -- move between open files
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
        },
        keys = {
            {
                "<leader>j",
                function()
                    require("harpoon"):list():append()
                end,
                desc = "Harpoon file",
            },
            {
                "<leader>h",
                function()
                    local harpoon = require "harpoon"
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon quick menu",
            },
            {
                "<leader>1",
                function()
                    require("harpoon"):list():select(1)
                end,
                desc = "Harpoon to file 1",
            },
            {
                "<leader>2",
                function()
                    require("harpoon"):list():select(2)
                end,
                desc = "Harpoon to file 2",
            },
            {
                "<leader>3",
                function()
                    require("harpoon"):list():select(3)
                end,
                desc = "Harpoon to file 3",
            },
            {
                "<leader>4",
                function()
                    require("harpoon"):list():select(4)
                end,
                desc = "Harpoon to file 4",
            },
            {
                "<leader>5",
                function()
                    require("harpoon"):list():select(5)
                end,
                desc = "Harpoon to file 5",
            },
        },
    },
}
