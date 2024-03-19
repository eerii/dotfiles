-- per server configuration
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                        [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    },

    html = {},
}

-- create a custom on_attach function (mainly for custom keybinds)
local on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set
    local conf = require "nvconfig".ui.lsp

    map("n", "gD", vim.lsp.buf.declaration, opts "LSP Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "LSP Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "LSP Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "LSP Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "LSP Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "LSP Remove workspace folder")

    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "LSP List workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "LSP Go to type definition")

    map("n", "<leader>ra", function()
        require "nvchad.lsp.renamer" ()
    end, opts "LSP NvRenamer")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "LSP Code action")
    map("n", "gr", vim.lsp.buf.references, opts "LSP Show references")

    -- setup signature popup
    if conf.signature and client.server_capabilities.signatureHelpProvider then
        require "nvchad.lsp.signature".setup(client, bufnr)
    end
end

-- setyo all the servers
for name, opts in pairs(servers) do
    local configs = require "nvchad.configs.lspconfig"

    opts.on_init = configs.on_init
    opts.capabilities = configs.capabilities
    opts.on_attach = on_attach

    require "lspconfig"[name].setup(opts)
end
