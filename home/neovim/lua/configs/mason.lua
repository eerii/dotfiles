local opts = {
    ensure_installed = {
        "lua-language-server",
        "stylua",
        "clangd",
        "clang-format",
        "html-lsp",
        "css-lsp",
        "prettier",
        "bash-language-server",
        "beautish",
        "jdtls",
        "taplo",
        "basedpyright",
        "black",
    },
    automatic_installation = {
        exclude = { "rust_analyzer" },
    },
}

return opts
