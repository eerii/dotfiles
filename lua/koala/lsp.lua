local lsp = require('lsp-zero')
local cmp = require('cmp')

-- Settings

local lua_settings = {
    Lua = {
        diagnostics = {
            globals = { 'vim' }
        }
    }
}

local python_settings = {
    pylsp = {
        plugins = {
            pycodestyle = {
                ignore = {'E265', 'E302', 'E305'},
            }
        }
    }
}

local typescript_settings = {
    completions = {
        completeFunctionCalls = true
    }
}

local lsp_config = {
    set_lsp_keymaps = false,
}

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp_config = {
    method = 'getCompletionsCycling',
    sources = {
        { name = 'copilot', max_item_count = 3},
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = lsp.defaults.cmp_mappings({
        ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end),
        ['<S-CR>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
                cmp.close()
            end
            fallback()
        end),
    }),
    window = {
        border = 'rounded',
    },
    experimental = {
        ghost_text = true,
    }
}

-- Initialization

local lsp_zero = function ()
    -- Recommended settings
    lsp.preset('recommended')

    -- Default language servers (WIP)
    lsp.ensure_installed({
        'clangd',
        'sumneko_lua',
        'tsserver',
        'eslint',
        'html',
        'cssls'
    })

    -- Configure LSPs
    lsp.configure('sumneko_lua', { settings = lua_settings })
    lsp.configure('pylsp', { settings = python_settings })
    lsp.configure('tsserver', { settings = typescript_settings })

    -- LSP and CMP preferences
    lsp.set_preferences(lsp_config)
    lsp.setup_nvim_cmp(cmp_config)

    -- Setup LSP
    lsp.setup()
end

return {
    lsp_zero = lsp_zero
}
