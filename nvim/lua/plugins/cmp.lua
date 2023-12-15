vim.g.enable_autocomplete = true
vim.api.nvim_create_user_command("ToggleCmp", function(_)
	vim.g.enable_autocomplete = not vim.g.enable_autocomplete

	local cmp = require("cmp")
	local autocomplete = vim.g.enable_autocomplete and { cmp.TriggerEvent.TextChanged } or false

	cmp.setup.buffer({ completion = { autocomplete = autocomplete } })
	vim.notify("Auto completions " .. (vim.g.enable_autocomplete and "enabled" or "disabled"))
end, {
	desc = "Toggle auto completions",
})

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"l3mon4d3/luasnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"jmarkin/cmp-diag-codes",
			"exafunction/codeium.vim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local cmp_mapping = function(fn_cmp, fn_codeium, fn_luasnip)
				return cmp.mapping(function(fallback)
					---@diagnostic disable-next-line: undefined-field
					if vim.b._codeium_completions ~= nil and fn_codeium then
						fn_codeium()
					elseif cmp.visible() then
						fn_cmp()
					elseif luasnip.expand_or_jumpable() and fn_luasnip then
						fn_luasnip()
					else
						fallback()
					end
				end, { "i", "s" })
			end

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "codeium" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip", max_item_count = 3 },
					{ name = "nvim_lua" },
					{ name = "diag-codes", option = { in_comment = true } },
				},
				preselect = cmp.PreselectMode.Item,
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp_mapping(function()
						cmp.confirm({ select = true })
					end, function()
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes(vim.fn["codeium#Accept"](), true, true, true),
							""
						)
					end, luasnip.expand_or_jump),
					["<C-n>"] = cmp_mapping(function()
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					end, function()
						vim.fn["codeium#CycleCompletions"](1)
					end, nil),
					["<C-p>"] = cmp_mapping(function()
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					end, function()
						vim.fn["codeium#CycleCompletions"](-1)
					end, nil),
					["<C-w>"] = cmp.mapping(function(_)
						cmp.abort()
						---@diagnostic disable-next-line: undefined-field
						if vim.b._codeium_completions then
							vim.fn["codeium#Clear"]()
						else
							vim.fn["codeium#Complete"]()
						end
					end),
					["<C-e>"] = cmp_mapping(cmp.abort, nil, nil),
					["<C-d>"] = cmp_mapping(function()
						cmp.mapping.scroll_docs(-4)
					end, nil, nil),
					["<C-u>"] = cmp.mapping(function()
						cmp.mapping.scroll_docs(4)
					end, nil, nil),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							symbol_map = vim.g.symbol_map,
							maxwidth = 40,
						})(entry, vim_item)
						local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
						kind.kind = string.format(" %s │", strings[1], strings[2])
						return kind
					end,
				},
				window = {
					documentation = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
						scrollbar = false,
						col_offset = 0,
					},
					completion = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
						scrollbar = false,
						col_offset = 0,
						side_padding = 0,
					},
				},
				performance = {
					debounce = 150,
					max_view_entries = 8,
				},
				experimental = {
					ghost_text = true,
				},
			})
		end,
		keys = {
			{ "<leader>tc", "<CMD>ToggleCmp<CR>", desc = "Toggle auto compeltions" },
		},
	},

	{
		"l3mon4d3/luasnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
		end,
	},

	{
		"exafunction/codeium.vim",
		config = function()
			vim.g.codeium_disable_bindings = true
			vim.g.codeium_manual = true
		end,
		event = "InsertEnter",
		cmd = "Codeium",
	},
}
