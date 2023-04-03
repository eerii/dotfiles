return {
    -- LSP Support
    {
        'vonheikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            {
                'williamboman/mason.nvim',
                build = ':MasonUpdate',
                cmd = { 'Mason', 'MasonUpdate' },
                keys = { { '<leader>M', ':Mason<CR>', desc = '[M]ason Language Servers' } },
            },
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind.nvim',
            'l3mon4d3/luasnip',
            'tzachar/fuzzy.nvim',
            'tzachar/cmp-fuzzy-buffer',
            'simrat39/rust-tools.nvim',
            {
                'zbirenbaum/copilot.lua',
                opts = {
                    suggestion = {
                        enabled = true,
                        auto_trigger = false,
                        keymap = {
                            accept = false,
                        }
                    },
                    panel = {
                        enabled = true,
                        auto_refresh = true,
                    },
                    filetypes = {
                        markdown = true,
                    }
                },
                keys = {
                    {
                        '<C-w>',
                        function()
                            require('cmp').close()
                            require('copilot.suggestion').next()
                        end,
                        desc = 'Trigger Copilot',
                        mode = 'i'
                    },
                    {
                        '<leader>cp',
                        function()
                            require('copilot.panel').open()
                        end,
                        desc = 'Copilot panel',
                    },
                    {
                        '<leader>cs',
                        ':Copilot<CR>',
                        desc = 'Copilot status',
                    },
                    {
                        '<leader>ct',
                        ':Copilot toggle<CR>',
                        desc = 'Copilot toggle',
                    }
                }
            }
        },
        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(_, _)
                --lsp.default_keymaps({buffer = buf})
            end)

            lsp.format_mapping('<leader>f', {
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                }
            })

            local config = require('lspconfig')
            config.lua_ls.setup(lsp.nvim_lua_ls())

            lsp.skip_server_setup({ 'rust_analyzer' })
            lsp.setup()

            local rt = require('rust-tools')
            local cargo_env = { CARGO_TARGET_DIR = './target.nosync' }
            rt.setup({
                server = {
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = { extraEnv = cargo_env },
                            server = { extraEnv = cargo_env },
                            runnableEnv = cargo_env,
                            checkOnSave = { command = 'clippy' }
                        }
                    },
                    on_attach = function(_, bufnr)
                        vim.keymap.set('n', '<leader>ca', rt.hover_actions.hover_actions, { buffer = bufnr })
                    end
                },
            })

            local cmp = require('cmp')
            local copilot = require('copilot.suggestion')

            cmp.setup({
                sources = cmp.config.sources({
                    -- { name = 'copilot',                 max_item_count = 3 },
                    { name = 'nvim_lsp',                max_item_count = 3 },
                    { name = 'nvim_lsp_signature_help', max_item_count = 3 },
                    --{ name = 'luasnip', max_item_count = 3 },
                    { name = 'fuzzy_buffer',            max_item_count = 3 },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if copilot.is_visible() then
                            copilot.accept()
                        elseif cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function(_)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            if copilot.is_visible() then
                                copilot.dismiss()
                            end
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                }),
            })
        end,
        event = { 'BufEnter' },
        keys = {
            { '[d',          vim.diagnostic.goto_next,   desc = 'LSP next [D]iagnostic' },
            { ']d',          vim.diagnostic.goto_prev,   desc = 'LSP previous [D]iagnostic' },
            { 'gd',          vim.diagnostic.open_float,  desc = 'LSP show line [D]iagnostics' },
            { 'gh',          vim.lsp.buf.hover,          desc = '[L]SP [H]over info' },
            { '<leader>lsp', ':LspInfo<CR>',             desc = '[LSP] Info' },
            { '<leader>li',  vim.lsp.buf.implementation, desc = '[L]SP [I]mplementation' },
            { '<leader>ca',  vim.lsp.buf.code_action,    desc = 'LSP [C]ode [A]ctions' },
        }
    }
}
