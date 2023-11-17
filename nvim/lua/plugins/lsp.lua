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

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"hrsh7th/nvim-cmp",
			"folke/neodev.nvim", -- Neovim development
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(e)
					local map = vim.keymap.set
					map("n", "gh", vim.lsp.buf.hover, { buffer = e.buf, desc = "[L]SP [H]over info" })
					map("n", "ga", vim.lsp.buf.code_action, { buffer = e.buf, desc = "[L]SP [C]ode [A]ctions" })
					map("n", "gs", vim.lsp.buf.declaration, { buffer = e.buf, desc = "[L]SP [D]eclaration" })
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

			-- Mason config
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
				},
				automatic_installation = {
					exclude = { "rust_analyzer" },
				},
				handlers = {
					function(server_name)
						lsp[server_name].setup({})
					end,
					["jdtls"] = function() end,
				},
			})

			-- Per LSP settings
			lsp.lua_ls.setup({
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			})
		end,
		event = "BufRead",
		keys = {
			{ "[d", vim.diagnostic.goto_next, desc = "LSP next [D]iagnostic" },
			{ "]d", vim.diagnostic.goto_prev, desc = "LSP previous [D]iagnostic" },
			{ "gd", vim.diagnostic.open_float, desc = "LSP show line [D]iagnostics" },
			{ "<leader>lsp", ":LspInfo<CR>", desc = "[LSP] Info" },
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = { "Mason", "MasonUpdate" },
		keys = { { "<leader>m", ":Mason<CR>", desc = "[M]ason Language Servers" } },
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
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" },
					},
				},
				server = {
					on_attach = function(_, _) end,
				},
			})
		end,
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
}
