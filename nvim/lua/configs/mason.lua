local opts = {
    ensure_installed = {
        "lua-language-server",
        "stylua",
        "clangd",
        "html-lsp",
        "css-lsp",
        "prettier",
        "jdtls",
        "taplo",
        "codelldb",
    },
    automatic_installation = {
        exclude = { "rust_analyzer" },
    },
}

require "mason".setup(opts)
