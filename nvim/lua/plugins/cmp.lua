-- Completions
-- Use different sources to offer autocompletions

-- Setup
--  · nvim-cmp (the main completion plugin)
--  · luasnip (snippet provider)
--  · copilot (add copilot suggestions to cmp completions)

-- Helper function
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match('^%s*$') == nil
end

return {
    {
        'hrsh7th/nvim-cmp',
        version = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
        opts = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            return {
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-CR>'] = vim.schedule_wrap(function(fallback) -- don't select anything
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end),
                    ['<CR>'] = cmp.mapping.confirm({ -- copilot-cmp
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'copilot', max_item_count = 3 },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'luasnip' },
                    { name = 'buffer', max_item_count = 5 },
                    { name = 'path' },
                }),
                window = {
                    --completion = {},
                    --documentation = { border = 'rounded' },
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
        event = 'InsertEnter'
    },
    {
        'l3mon4d3/luasnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets'})
        end,
        event = 'InsertEnter'
    },
    {
        'zbirenbaum/copilot-cmp',
        dependencies = {
            'zbirenbaum/copilot.lua',
            opts = {
                cmp = {
                    enabled = true,
                    method = 'getCompletionsCycling',
                },
                suggestion = { enabled = false },
                server_opts_overrides = {
                    settings = {
                        advanced = {
                            inlineSuggestCount = 3,
                        }
                    }
                },
                filetypes = { markdown = true }
            }
        },
        config = true,
        event = 'InsertEnter'
    },
    {
        'kdheepak/cmp-latex-symbols',
        ft = { 'tex', 'markdown' }
    },
    {
        'petertriho/cmp-git', -- : commits, # issues and pr, @ mentions
        opts = {
            filetypes = { 'gitcommit', 'octo', 'markdown' },
        },
        ft = { 'gitcommit', 'octo', 'markdown' }
    }
}
