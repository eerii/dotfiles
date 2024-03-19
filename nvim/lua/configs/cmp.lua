local opts = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local config = require "nvchad.configs.cmp"

    local cmp_mapping = function(fn_cmp, fn_codeium, fn_copilot, fn_luasnip, fn_luasnip_test)
        return cmp.mapping(function(fallback)
            if vim.b._codeium_completions ~= nil and fn_codeium then
                fn_codeium()
            elseif cmp.visible() and fn_cmp then
                fn_cmp()
            elseif fn_luasnip_test and fn_luasnip_test() and fn_luasnip then
                fn_luasnip()
            else
                fallback()
            end
        end, { "i", "s" })
    end

    config.mapping = {
        ["<Tab>"] = cmp_mapping(function()
            cmp.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }
        end, function()
            vim.fn.feedkeys(
                vim.api.nvim_replace_termcodes(vim.fn["codeium#Accept"](), true, true, true),
                ""
            )
        end, nil, luasnip.expand_or_jump, luasnip.expand_or_jumpable),

        ["<S-Tab>"] = cmp_mapping(nil, nil, nil, function()
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        end, function()
            return luasnip.jumpable(-1)
        end),

        ["<C-n>"] = cmp_mapping(cmp.select_next_item, function()
            vim.fn["codeium#CycleCompletions"](1)
        end, nil, nil, nil),

        ["<C-p>"] = cmp_mapping(cmp.select_prev_item, function()
            vim.fn["codeium#CycleCompletions"](-1)
        end, nil, nil, nil),

        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.close(),

        ["<C-q>"] = cmp.mapping(function(_)
            cmp.abort()
            if vim.b._codeium_completions then
                vim.fn["codeium#Clear"]()
            else
                vim.fn["codeium#Complete"]()
            end
        end),
    }

    return config
end

require "cmp".setup(opts())
