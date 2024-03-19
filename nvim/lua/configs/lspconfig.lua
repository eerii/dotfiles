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
                    hint = {
                        enable = true,
                    },
                },
            },
        },
    },

    html = {},
    cssls = {
        settings = {
            css = {
                lint = {
                    emptyRules = "ignore",
                }
            }
        }
    },

    taplo = {
        keys = {
            {
                "gh",
                function()
                    if vim.fn.expand("%:t") == "Cargo.toml" and require "crates".popup_available() then
                        require "crates".show_popup()
                    else
                        vim.lsp.buf.hover()
                    end
                end,
                desc = "Show crate documentation",
            },
        },
    },

    clangd = {},
}

-- setyo all the servers
for name, opts in pairs(servers) do
    local configs = require "nvchad.configs.lspconfig"

    opts.on_init = configs.on_init
    opts.capabilities = configs.capabilities
    opts.on_attach = require "configs.onattach"

    require "lspconfig"[name].setup(opts)
end
