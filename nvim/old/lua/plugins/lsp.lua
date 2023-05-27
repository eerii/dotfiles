local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

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
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind.nvim',
            'l3mon4d3/luasnip',
            'saadparwaiz1/cmp_luasnip',
            'felipelema/cmp-async-path',
            'paopaol/cmp-doxygen',
            'simrat39/rust-tools.nvim',
            'smiteshp/nvim-navic',
            'p00f/clangd_extensions.nvim',
            {
                'quarto-dev/quarto-nvim',
                dependencies = { {
                    'jmbuhr/otter.nvim',
                    dev = false,
                    config = function()
                        require 'otter.config'.setup()
                    end
                } },
                config = true
            },
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
            },
        },
        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(client, buf)
                --lsp.default_keymaps({buffer = buf})
                if client.server_capabilities.documentSymbolProvider then
                    require('nvim-navic').attach(client, buf)
                end
            end)

            lsp.format_mapping('<leader>f', {
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                }
            })

            local config = require('lspconfig')
            config.lua_ls.setup(lsp.nvim_lua_ls())

            lsp.skip_server_setup({ 'rust_analyzer', 'clangd' })
            lsp.setup()

            local signs = { Error = '', Warn = '', Hint = '', Info = '' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

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

            local cld = require('clangd_extensions')
            cld.setup({
                server = {
                    capabilities = {
                        offset_encoding = "utf-8"
                    }
                }
            })

            local cmp = require('cmp')
            local copilot = require('copilot.suggestion')
            local luasnip = require('luasnip')

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lua',                max_item_count = 3 },
                    { name = 'nvim_lsp',                max_item_count = 5 },
                    { name = 'nvim_lsp_signature_help', max_item_count = 3 },
                    { name = 'otter',                   max_item_count = 3 },
                    { name = 'luasnip',                 max_item_count = 3 },
                    { name = 'async_path',              max_item_count = 7 },
                    { name = 'doxygen',                 max_item_count = 7 },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if copilot.is_visible() then
                            copilot.accept()
                        elseif cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
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
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = border 'CmpBorder',
                        scrollbar = false,
                    },
                    documentation = {
                        border = border 'CmpBorder',
                        winhighlight = 'Normal:CmpDoc',
                        scrollbar = false,
                        max_height = 15,
                        max_width = 60,
                    }
                },
                formatting = {
                    format = require('lspkind').cmp_format {
                        maxwidth = 50,
                        ellipsis_char = '...',
                        fields = { 'abbr', 'kind' },
                        menu = {},
                    },
                }
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
            { '<C-n>',       ':Navbuddy<CR>',            desc = '[N]avigate scopes' }
        }
    }
}
