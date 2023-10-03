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

    -- Plantuml renderer
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
    },

    -- Pandoc renderer
    {
        "garciabarreiro/nvim-pandoc",
        dir = "~/Code/nvim-pandoc",
        ft = { "markdown", "latex" },
        keys = {
            { "<leader>p", function()
                vim.api.nvim_create_augroup("Pandoc", { clear = false })
                vim.api.nvim_clear_autocmds({ buffer = 0, group = "Pandoc" })
                vim.api.nvim_create_autocmd("BufWritePost", {
                    group = "Pandoc",
                    buffer = 0,
                    callback = function()
                        vim.cmd("PandocWrite")
                    end
                })
                vim.cmd("PandocRead")
            end, desc = "Pandoc enable" },
        }
    }
}
