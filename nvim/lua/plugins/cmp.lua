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
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local copilot = require("copilot.suggestion")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip", max_item_count = 5 },
					{ name = "nvim_lua" },
					{ name = "diag-codes", option = { in_comment = true } },
				},
				preselect = cmp.PreselectMode.Item,
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.accept()
						elseif cmp.visible() then
							cmp.confirm({ select = true })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-j>"] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.next()
						elseif cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.prev()
						elseif cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-e>"] = cmp.mapping(function(_)
						if cmp.visible() then
							cmp.abort()
						else
							copilot.dismiss()
							cmp.complete()
						end
					end, { "i", "s" }),

					["<C-w>"] = cmp.mapping(function(_)
						if copilot.is_visible() then
							copilot.dismiss()
						else
							cmp.abort()
							copilot.next()
						end
					end, { "i", "s" }),

					["<C-d>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.mapping.scroll_docs(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-f>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.mapping.scroll_docs(1)
						else
							fallback()
						end
					end, { "i", "s" }),
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
		"zbirenbaum/copilot.lua",
		opts = {
			panel = {
				enabled = false,
			},

			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 75,
				keymap = {
					["*"] = false,
				},
			},

			filetypes = {
				["*"] = true,
			},
		},
		event = "InsertEnter",
	},
}
