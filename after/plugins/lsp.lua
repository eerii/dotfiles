local lsp = require('lsp-zero')
local cmp = require('cmp')
local mason_dap = require('mason-nvim-dap')

-- LSP zero recommended settings
lsp.preset('recommended')

-- Default language servers (WIP)
lsp.ensure_installed({
	'clangd',
	'tsserver',
	'sumneko_lua',
    'jdtls'
})

-- Fix undefined vim
lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

-- Configure jdtls
lsp.configure('jdtls', {

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
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
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
