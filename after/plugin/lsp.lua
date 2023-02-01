local lsp = require('lsp-zero')

local cmp = require('cmp')
local mason_dap = require('mason-nvim-dap')

-- LSP zero recommended settings
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

-- Configure neodev
require('neodev').setup({
    library = { plugins = { 'nvim-dap-ui' }, types = true },
})

-- Configure sumneko_lua
lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

-- Configure python
lsp.configure('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'E265', 'E302', 'E305'},
                }
            }
        }
    }
})

-- Configure typescript
lsp.configure('tsserver', {
    settings = {
        completions = {
            completeFunctionCalls = true
        }
    }
})

-- Disable predefined keybindings
lsp.set_preferences({
	set_lsp_keymaps = false,
})

-- Setup cmp sources
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

lsp.setup_nvim_cmp({
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
        ['<Esc>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
                cmp.close()
            else
                fallback()
            end
        end),
    }),
    window = {
        border = 'rounded',
    },
    experimental = {
        ghost_text = true,
    }
})

-- Setup autopairs
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

-- LSP zero setup
lsp.setup()

-- Load mason DAP support
mason_dap.setup{ automatic_setup = true }
mason_dap.setup_handlers()

-- Diagnostic override settings
vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true,
    float = { focusable = true },
}
