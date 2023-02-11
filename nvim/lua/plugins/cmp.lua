-- Completions

-- Use different sources to offer autocompletions

-- Setup
--  · nvim-cmp (the main completion plugin)
--  · luasnip (snippet provider)
--  · copilot (add copilot suggestions to cmp completions)

vim.g.cmptoggle = false
vim.g.copilottoggle = false

return {
    {
        'hrsh7th/nvim-cmp',
        version = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'felipelema/cmp-async-path',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'tzachar/fuzzy.nvim',
            'tzachar/cmp-fuzzy-buffer',
            'tzachar/cmp-fuzzy-path',
            'hrsh7th/cmp-nvim-lua',
            {
                'l3mon4d3/luasnip',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                },
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                    require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets'})
                end,
            },
            {
                'zbirenbaum/copilot-cmp',
                dependencies = {
                    'zbirenbaum/copilot.lua',
                    opts = {
                        cmp = {
                            enabled = function() return not vim.g.copilottoggle end,
                            method = 'getCompletionsCycling',
                        },
                        suggestion = { enabled = function() return vim.g.copilottoggle end },
                        panel = { enabled = false },
                        filetypes = { markdown = true },
                    },
                    keys = {
                        { '<C-w>', function()
                            if vim.g.cmptoggle then
                                require('cmp').close()
                            end
                            vim.g.cmptoggle = false

                            vim.g.copilottoggle = true
                            require('copilot.suggestion').next()
                        end, desc = 'Trigger Copilot', mode = 'i' },
                        { '<C-q>', function()
                            local copilot = require('copilot.suggestion')

                            if vim.g.cmptoggle then
                                require('cmp').close()
                            end
                            vim.g.cmptoggle = false

                            if copilot.is_visible() then
                                copilot.dismiss()
                            end
                        end, desc = 'Dismiss Copilot and Completions', mode = 'i' },
                        { '<Tab>', function()
                            local copilot = require('copilot.suggestion')

                            if copilot.is_visible() then
                                copilot.accept()
                            else
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
                            end
                        end, desc = 'Copilot Complete', mode = 'i' },
                        { '<C-Enter>', function()
                            local copilot = require('copilot.suggestion')

                            if copilot.is_visible() then
                                copilot.accept_word()
                                copilot.next()
                            else
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-Tab>', true, false, true), 'n', false)
                            end
                        end, desc = 'Copilot Complete Word', mode = 'i' },
                    }
                },
                config = true,
            }
        },
        opts = function()
            local cmp = require('cmp')
            local copilot = require('copilot.suggestion')
            local luasnip = require('luasnip')

            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#26C281' })

            return {
                enabled = function()
                    return vim.g.cmptoggle
                end,
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-Enter>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'copilot', max_item_count = 3 },
                    { name = 'nvim_lsp', max_item_count = 3 },
                    { name = 'nvim_lsp_signature_help', max_item_count = 3 },
                    { name = 'luasnip', max_item_count = 3 },
                    { name = 'fuzzy_buffer', max_item_count = 3 },
                    { name = 'async_path', max_item_count = 3 },
                    { name = 'crates', max_item_count = 3 },
                    { name = 'nvim_lua', max_item_count = 3 },
                }),
                formatting = {
                    format = require('lspkind').cmp_format({
                        symbol_map = { Copilot = '' },
                        mode = 'symbol',
                        maxwidth = 32,
                        ellipsis_char = '…',

                        before = function(_, vim_item)
                            return vim_item
                        end,
                    })
                },
                experimental = {
                    ghost_text = {
                        hl_group = 'LspCodeLens',
                    },
                },
            }
        end,
        config = function(_, opts)
            local cmp = require('cmp')
            cmp.setup(opts)

            local add_sources = function (ft, sources)
                local new_sources = vim.deepcopy(opts.sources)
                for _, s in ipairs(sources) do
                    table.insert(new_sources, s)
                end
                cmp.setup.filetype(ft, { sources = new_sources })
            end

            add_sources({ 'gitcommit', 'octo' }, { { name = 'git' } })
            add_sources({ 'tex' }, { { name = 'latex_symbols' } })
            add_sources({ 'markdown' }, { { name = 'git' }, { name = 'latex_symbols' } })
        end,
        keys = {
            { '<C-e>', function()
                vim.g.cmptoggle = not vim.g.cmptoggle
                if vim.g.cmptoggle then
                    vim.g.copilottoggle = false
                end
                print('completions ' .. (vim.g.cmptoggle and 'enabled' or 'disabled'))
            end, desc = 'Toggle Completions', mode = 'n' },
            { '<C-e>', function()
                vim.g.cmptoggle = not vim.g.cmptoggle
                if vim.g.cmptoggle then
                    vim.g.copilottoggle = false
                    vim.api.nvim_exec('stopinsert', false)
                    vim.api.nvim_feedkeys('a', 'n', true)
                    require('cmp').complete()
                end
            end, desc = 'Toggle Completions', mode = 'i' },
        },
    },
}
