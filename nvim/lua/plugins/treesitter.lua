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
                highlight = {
                    enable = true,
                    disable = { "markdown" }
                },
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
    },

    -- Markdown improved syntax
    {
        "plasticboy/vim-markdown",
        branch = "master",
        require = {"godlygeek/tabular"},
        config = function()
            vim.g.vim_markdown_folding_style_pythonic = 1
            
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "markdown",
                callback = function()
                    vim.o.foldlevel = 99
                end,
            })
        end,
        ft = "markdown"
    },
}
