vim.api.nvim_create_user_command("ToggleFormat", function(args)
    if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
    else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
    end
end, {
    desc = "Toggle format on save",
    bang = true,
})

vim.g.disable_autoformat = false

local opts = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "clang-format" },
        rust = { "rustfmt" },
        html = { "prettier" },
        css = { "prettier" },
        python = { "black" },
        bash = { "beautish" },
        zsh = { "beautish" },
        sh = { "beautish" },
        toml = { "taplo" },
        nix = { "nixfmt" },
    },

    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
}

require("conform").setup(opts)
