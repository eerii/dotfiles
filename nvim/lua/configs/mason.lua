local opts = {
    ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier"
    },
}

require "mason".setup(opts)
