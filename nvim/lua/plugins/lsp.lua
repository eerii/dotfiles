return {
    -- lsp
    {
        "neovim/nvim-lspconfig",
        config = function()
            dofile(vim.g.base46_cache .. "lsp")
            require "nvchad.lsp"
            require "configs.lspconfig"
        end,
    },

    -- install modules
    {
        "williamboman/mason.nvim",
        config = function()
            require "configs.mason"
        end,
    },

    -- file formatting
    {
        "stevearc/conform.nvim",
        config = function()
            require "configs.conform"
        end,
        event = "BufWritePre",

    },

    -- trouble (diagnostics list)
    {
        "folke/trouble.nvim",
        opts = {},
        keys = {
            { "<leader>sd", function() require("trouble").toggle("document_diagnostics") end,  desc = "Trouble document diagnostics" },
            { "<leader>sw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Trouble workspace diagnostics" },
        },
    },
}
