-- Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-- Parsing tool for code, better syntax understanding

return {
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle'
    },
    {
        'nvim-treesitter/nvim-treesitter-context', -- Function namespaces
        event = 'BufReadPre',
        config = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'python',
                'c', 'cpp', 'make', 'cmake', 'glsl',
                'javascript', 'typescript', 'css', 'html', 'json', 'yaml',
                'latex', 'bibtex', 'markdown',
                'java', 'sql',
                'lua', 'vim', 'help'
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {}
            }
        }
    }
}
