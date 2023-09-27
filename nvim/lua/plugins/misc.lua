return {
    -- Learn to use vim
    {
        "m4xshen/hardtime.nvim",
        dependencies = {
            "muniftanjim/nui.nvim",
            "nvim-lua/plenary.nvim"
        },
        opts = {
            disable_mouse = false,
            disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "minifiles" },
            restriction_mode = "hint",
            allow_different_key = true
        },
        event = "VeryLazy",
        keys = {
            { "<leader>ht", "<CMD>Hardtime toggle<CR>", desc = "Toggle Hardtime" },
            { "<leader>hr", "<CMD>Hardtime report<CR>", desc = "Hardtime Report" },
        }
    },

    -- Keymaps
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {}
    },

    {
        "https://gitlab.com/itaranto/plantuml.nvim",
        version = "*",
        opts = {
            renderer = {
                type = "imv",
                options = {
                    dark_mode = true,
                }
            }
        },
        ft = "plantuml"
    }
}
