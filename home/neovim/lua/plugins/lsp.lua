return {
	-- lsp
	{
		"neovim/nvim-lspconfig",
		config = function()
			dofile(vim.g.base46_cache .. "lsp")
			require("nvchad.lsp")
			require("configs.lspconfig")
		end,
	},

	-- install modules
	{
		"williamboman/mason.nvim",
		opts = require("configs.mason"),
	},

	-- file formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
		event = "BufWritePre",
		keys = {
			{ "<leader>tf", "<CMD>ToggleFormat<CR>", desc = "Toggle auto-format" },
		},
	},

	-- trouble (diagnostics list)
	{
		"folke/trouble.nvim",
		opts = {},
		keys = {
			{
				"<leader>sd",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				desc = "Trouble document diagnostics",
			},
			{
				"<leader>sw",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Trouble workspace diagnostics",
			},
		},
	},

	-- inline hints
	{
		"mysticaldevil/inlay-hints.nvim",
		opts = {
			autocmd = { enable = false },
		},
		keys = {
			{ "<leader>ih", "<CMD>InlayHintsToggle<CR>", desc = "Inline hints" },
		},
	},

	-- rust (crashing)
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	opts = {
	-- 		server = {
	-- 			on_attach = function(client, bufnr)
	-- 				require("configs.onattach")(client, bufnr)
	--
	-- 				local function opts(desc)
	-- 					return { buffer = bufnr, desc = desc }
	-- 				end
	--
	-- 				vim.keymap.set("n", "ga", function()
	-- 					vim.cmd.RustLsp("codeAction")
	-- 				end, opts("Rust code action"))
	-- 				vim.keymap.set("n", "<leader>rd", function()
	-- 					vim.cmd.RustLsp("renderDiagnostic")
	-- 				end, opts("Rust diagnostics"))
	-- 				vim.keymap.set("n", "<leader>rb", function()
	-- 					vim.cmd.RustLsp("debuggables")
	-- 				end, opts("Rust debuggables"))
	-- 				vim.keymap.set("n", "<leader>rr", function()
	-- 					vim.cmd.RustLsp("runnables")
	-- 				end, opts("Rust runnables"))
	-- 				vim.keymap.set("n", "<leader>rt", function()
	-- 					vim.cmd.RustLsp("testables")
	-- 				end, opts("Rust testables"))
	-- 				vim.keymap.set("n", "<leader>re", function()
	-- 					vim.cmd.RustLsp("explainError")
	-- 				end, opts("Rust explain error"))
	-- 				vim.keymap.set("n", "<leader>rj", function()
	-- 					vim.cmd.RustLsp("joinLines")
	-- 				end, opts("Rust join lines"))
	-- 			end,
	-- 			settings = function(project_root)
	-- 				local default = {
	-- 					["rust-analyzer"] = {
	-- 						assist = { expressionFillDefault = "default" },
	-- 						checkOnSave = {
	-- 							command = "clippy",
	-- 							extraArgs = { "--no-deps" },
	-- 						},
	-- 						diagnostics = {
	-- 							disabled = { "unresolved-proc-macro" },
	-- 							experimental = { enable = true },
	-- 						},
	-- 						procMacro = {
	-- 							enable = false,
	-- 							attributes = { enable = false },
	-- 						},
	-- 					},
	-- 				}
	-- 				-- Check if project_root/rust-analyzer.lua exists
	-- 				local settings_file = project_root .. "/rust-analyzer.lua"
	-- 				if vim.fn.filereadable(settings_file) == 0 then
	-- 					return default
	-- 				end
	--
	-- 				-- Extend the table with it
	-- 				package.path = package.path .. settings_file
	-- 				local settings = require("rust-analyzer")
	-- 				default["rust-analyzer"] = vim.tbl_deep_extend("force", default["rust-analyzer"], settings)
	-- 				return default
	-- 			end,
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
	-- 	end,
	-- 	ft = "rust",
	-- },

	{
		"saecki/crates.nvim",
		opts = {
			src = {
				cmp = { enabled = true },
			},
		},
		event = { "BufRead Cargo.toml" },
	},

	-- java
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
}
