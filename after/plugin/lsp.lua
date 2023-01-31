local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Default language servers (WIP)
lsp.ensure_installed({
	'clangd',
	'tsserver',
	'sumneko_lua',
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

-- Disable predefined keybindings
lsp.set_preferences({
	set_lsp_keymaps = false,
})

-- New keybindings
lsp.on_attach(function(client, bufnr)
	vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, { buffer = bufnr, remap = false, desc = '[G]et [D]efinition' })
	vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, { buffer = bufnr, remap = false, desc = '[H]over' })
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { buffer = bufnr, remap = false, desc = '[V]iew [W]ork [S]pace' })
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = bufnr, remap = false, desc = '[V]iew [D]iagnostic' })
	vim.keymap.set("n", "<leader>nd", function() vim.diagnostic.goto_next() end, { buffer = bufnr, remap = false, desc = '[N]ext [D]iagnostic' })
	vim.keymap.set("n", "<leader>pd", function() vim.diagnostic.goto_prev() end, { buffer = bufnr, remap = false, desc = '[P]revious [D]iagnostic' })
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, { buffer = bufnr, remap = false, desc = '[V]iew [C]ode [A]ctions' })
	vim.keymap.set("n", "<leader>vrf", function() vim.lsp.buf.references() end, { buffer = bufnr, remap = false, desc = '[V]ariable [R]eferences' })
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { buffer = bufnr, remap = false, desc = '[V]ariable [R]ename' })
end)

lsp.setup()
