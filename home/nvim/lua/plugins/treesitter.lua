return {
    -- Treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- Provides a set of configurations and tools to work with treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
           "nvim-treesitter/nvim-treesitter-refactor" 
        },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "cpp", "rust", "python", "lua", "vim", "vimdoc", "query" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                refactor = {
                    highlight_definitions = { enable = true },
                    smart_rename = { enable = true },
                    navigation = { enable = true },
                },
            }
        end,
        event = "BufReadPre",
    }
}
