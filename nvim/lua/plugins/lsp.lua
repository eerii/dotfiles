-- LSP
-- Smart language features

-- Setup
--  · nvim-lspconfig (configures neovim lsp)
--  · mason (install language servers)

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                cmd = 'Mason',
                keys = { { '<leader>m', ':Mason<CR>', desc = '[M]ason Language Servers' } },
                opts = {
                    ensure_installed = {}
                }
            },
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = '●' },
                severity_sort = true,
            },
            servers = {
                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = {
                                globals = { 'vim', 'use' }
                            }
                        }
                    }
                },
                -- Python
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = {
                                    ignore = {'E265', 'E302', 'E305'},
                                }
                            }
                        }
                    }
                },
                -- Typescript
                tsserver = {
                    settings = {
                        completions = {
                            completefunctioncalls = true
                        }
                    }
                }
            },
            setup = {
                -- Additional server setup
            },
        },
        config = function(_, opts)
            -- Diagnostics
            vim.diagnostic.config(opts.diagnostics)

            -- Options
            local servers = opts.servers
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- Setup servers
            local setup = function(server)
                local server_opts = vim.tbl_deep_extend('force', {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup['*'] then
                    if opts.setup['*'](server, server_opts) then
                        return
                    end
                end
                require('lspconfig')[server].setup(server_opts)
            end

            -- Get servers
            local mlc = require('mason-lspconfig')
            local available = mlc.get_available_servers()
            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- Run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            -- Setup mason and lsp
            mlc.setup({ ensure_installed = ensure_installed })
            mlc.setup_handlers({ setup })
        end,
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '[d', vim.diagnostic.goto_next, desc = 'LSP next [D]iagnostic' },
            { ']d', vim.diagnostic.goto_prev, desc = 'LSP previous [D]iagnostic' },

            { '<leader>d', vim.diagnostic.open_float, desc = 'LSP show line [D]iagnostics' },
            { '<leader>h', vim.lsp.buf.hover, desc = 'LSP [H]over info' },
            { '<leader>lsp', ':LspInfo<CR>', desc = '[LSP] Info' },

            { 'gD', vim.lsp.buf.declaration, desc = 'LSP [G]o to [D]eclaration' },
            { 'gI', vim.lsp.buf.implementation, desc = 'LSP [G]o to [I]mplementation' },
            { 'gh', vim.lsp.buf.signature_help, desc = 'LSP [G]et [H]over signature help' },
            { mode = 'i', '<C-h>', vim.lsp.buf.signature_help, desc = 'LSP [G]et [H]over signature help' },

            { '<C-n>', vim.lsp.buf.rename, desc = 'LSP re[N]ame' },
            { '<leader>ca', vim.lsp.buf.code_action, desc = 'LSP [C]ode [A]ctions' },
            { '<leader>ff', vim.lsp.buf.format, desc = 'LSP [F]ormat [F]ile' },
        }
    },
    {
        'folke/neodev.nvim',
        opts = {
            experimental = {
                pathStrict = true,
            }
        },
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java'
    }
}
