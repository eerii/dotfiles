vim.api.nvim_create_user_command("ToggleFormat", function(args)
	if args.bang then
		---@diagnostic disable-next-line: inject-field
		vim.b.disable_autoformat = not vim.b.disable_autoformat
	else
		vim.g.disable_autoformat = not vim.g.disable_autoformat
	end
	vim.notify("Autoformat-on-save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})

-- LSP symbols
vim.g.symbol_map = {
	Text = "󰉿",
	Method = "󰆧",
	StaticMethod = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰯫",
	Class = "",
	Interface = "",
	Module = "",
	Namespace = "󰅪",
	Package = "󰏗",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Key = "󰌆",
	Keyword = "󰌆",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󱞡",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "",
	String = "",
	Number = "󰎠",
	Boolean = "󰱒",
	Array = "󱃶",
	Object = "󱗝",
	Null = "",
	Component = "",
	Fragment = "",
	Struct = "󰙅",
	Event = "󱐋",
	Operator = "󱨃",
	TypeParameter = "",
	Parameter = "",
	TypeAlias = "󰑕",
	Macro = "󰻃",
	Codeium = "󱝁",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"hrsh7th/nvim-cmp",
			{ "folke/neodev.nvim", ft = "lua" },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(e)
					local map = vim.keymap.set
					map("n", "gh", vim.lsp.buf.hover, { buffer = e.buf, desc = "[L]SP [H]over info" })
					map("n", "ga", vim.lsp.buf.code_action, { buffer = e.buf, desc = "[L]SP [C]ode [A]ctions" })
					map("n", "gD", vim.lsp.buf.declaration, { buffer = e.buf, desc = "[L]SP [D]eclaration" })
					map("n", "gd", function()
						require("trouble").toggle("lsp_definitions")
					end, { buffer = e.buf, desc = "[L]SP [D]efinition" })
					map("n", "gt", function()
						require("trouble").toggle("lsp_type_definitions")
					end, { buffer = e.buf, desc = "[L]SP [T]ype definition" })
					map("n", "gj", vim.lsp.buf.implementation, { buffer = e.buf, desc = "[L]SP [I]mplementation" })
					map("n", "gr", function()
						require("trouble").toggle("lsp_references")
					end, { buffer = e.buf, desc = "[L]SP [R]eferences" })
					map(
						"n",
						"gi",
						require("telescope.builtin").lsp_incoming_calls,
						{ buffer = e.buf, desc = "[L]SP [I]ncoming calls" }
					)
					map(
						"n",
						"go",
						require("telescope.builtin").lsp_outgoing_calls,
						{ buffer = e.buf, desc = "[L]SP [O]utgoing calls" }
					)
					map("n", "<leader>r", vim.lsp.buf.rename, { buffer = e.buf, desc = "[L]SP [R]ename" })
				end,
			})

			-- Specific filetype plugins
			require("neodev").setup()

			-- General LSP
			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Mason config
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
				},
				automatic_installation = {
					exclude = { "rust_analyzer", "clangd" },
				},
				handlers = {
					function(server_name)
						lsp[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["jdtls"] = function() end,
					["rust_analyzer"] = function() end,
				},
			})

			-- Per LSP settings
			lsp.lua_ls.setup({
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						hint = {
							enable = true,
						},
					},
				},
			})

			lsp.ocamllsp.setup({
				capabilities = capabilities,
			})

			lsp.cssls.setup({
				settings = {
					css = {
						lint = {
							emptyRules = "ignore",
						},
					},
				},
			})

            lsp.clangd.setup({
                capabilities = capabilities,
            })
		end,
		event = "InsertEnter",
		keys = {
			{ "[d", vim.diagnostic.goto_next, desc = "LSP next [D]iagnostic" },
			{ "]d", vim.diagnostic.goto_prev, desc = "LSP previous [D]iagnostic" },
			{ "ge", vim.diagnostic.open_float, desc = "LSP show line [D]iagnostics" },
			{ "<leader>lsp", ":LspInfo<CR>", desc = "[LSP] Info" },
		},
	},

	{
		"mysticaldevil/inlay-hints.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup({
				autocmd = { enable = false },
			})
		end,
		keys = {
			{ "<leader>h", "<CMD>InlayHintsToggle<CR>", desc = "Inline hints" },
		},
		event = "LspAttach",
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = { "Mason", "MasonUpdate" },
		keys = { { "<leader>M", ":Mason<CR>", desc = "[M]ason Language Servers" } },
	},

	-- Java
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local configure = function()
				local path = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/")
				local jar = vim.fn.glob(path .. "plugins/org.eclipse.equinox.launcher_*.jar")

				local root_markers = { "gradlew", ".git", "mvnw", "settings.gradle.kts" }
				local root_dir = require("jdtls.setup").find_root(root_markers)
				local workspace_folder = vim.fn.expand("~/.local/share/jdtls/")
					.. vim.fn.fnamemodify(root_dir, ":p:h:t")

				return {
					cmd = {
						"java",

						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xmx1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",

						"-jar",
						jar,
						"-configuration",
						path .. "config_linux",
						"-data",
						workspace_folder,
					},
					handlers = {
						["$/progress"] = function() end,
					},
					settings = {
						java = {},
					},
				}
			end

			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "java",
				callback = function()
					require("jdtls").start_or_attach(configure())
				end,
			})
		end,
		ft = "java",
	},

	-- Rust
	{
		"mrcjkb/rustaceanvim",
		config = function()
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					settings = function(project_root)
						local ra = require("rustaceanvim.config.server")
						local default = {
							["rust-analyzer"] = {
								assist = { expressionFillDefault = "default" },
								checkOnSave = {
									allFeatures = true,
									command = "clippy",
									extraArgs = { "--no-deps" },
								},
								diagnostics = { experimental = { enable = true } },
							},
						}
						local settings = ra.load_rust_analyzer_settings(project_root, {
							settings_file_pattern = "rust-analyzer.json",
						})
						return vim.tbl_deep_extend("force", default, settings)
					end,
				},
			}
		end,
		event = "InsertEnter",
		ft = "rust",
	},

	-- Formatter
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				java = { "clang-format" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				ocaml = { "ocamlformat" },
				css = { "prettier" },
			},
			format_after_save = function(buf)
				if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
		},
		keys = {
			{ "<leader>tf", "<CMD>ToggleFormat<CR>", desc = "Toggle format on save" },
		},
		event = "BufWritePre",
	},

	-- TODO: Lint

	-- Symbols
	{
		"hedyhli/outline.nvim",
		opts = {
			symbols = {
				icon_fetcher = function(name)
					return vim.g.symbol_map[name]
				end,
				icon_source = "lspkind",
			},
		},
		keys = {
			{ "gs", "<CMD>Outline<CR>", desc = "LSP Symbol outline" },
		},
	},
}
