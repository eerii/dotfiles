return {
	-- Treesitter
	-- https://github.com/nvim-treesitter/nvim-treesitter
	-- Provides a set of configurations and tools to work with treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			-- "nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-treesitter/nvim-treesitter-context",
		},
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"regex",
					"rust",
					"python",
					"lua",
					"markdown_inline",
					"vim",
					"vimdoc",
					"query",
				},
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "markdown" },
				},
				indent = { enable = true },
				incremental_selection = { enable = true },
				refactor = {
					highlight_definitions = { enable = true },
					smart_rename = { enable = true },
					navigation = { enable = true },
				},
				-- textobjects = {
				-- 	select = {
				-- 		enable = true,
				--
				-- 		keymaps = {
				-- 			["af"] = "@function.outer",
				-- 			["if"] = "@function.inner",
				-- 			["ac"] = "@class.outer",
				-- 			["ic"] = "@class.inner",
				-- 		},
				-- 	},
				-- },
			})

			-- require("treesitter-context").setup({ max_lines = 1, trim_scope = "outer" })
		end,
		event = "BufReadPre",
	},

	-- Markdown improved syntax
	{
		"plasticboy/vim-markdown",
		branch = "master",
		dependencies = { "godlygeek/tabular" },
		config = function()
			vim.g.vim_markdown_folding_style_pythonic = 1
		end,
		ft = "markdown",
	},
}
