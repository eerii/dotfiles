local opts = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "clang-format" },
        rust = { "rustfmt" },
        html = { "prettier" },
        css = { "prettier" },
        python = { "isort", "black " },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require "conform".setup(opts)
