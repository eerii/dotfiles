return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "nvim-treesitter/nvim-treesitter-context",
        },
        opts = {
            ensure_installed = {
                "c", "cpp", "regex", "rust", "python", "vim", "vimdoc", "lua",
                "markdown", "markdown_inline", "bash", "html", "css"
            },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-CR>",
                    node_incremental = "<C-CR>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
            refactor = {
                highlight_definitions = { enable = true },
                navigation = { enable = true },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
    },

    -- todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "<leader>st", "<CMD>TodoTrouble<CR>", desc = "Trouble todo list" }
        },
        event = "BufRead",
    },
}
