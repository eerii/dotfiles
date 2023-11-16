return {
	-- Telescope
	-- https://github.com/nvim-telescope/telescope.nvim
	-- Fuzzy finder and picker, powers many other utilities
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal_nolabel",
				mappings = {
					i = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
					n = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
				},
			},
		},
		config = function(_, opts)
			require("telescope.pickers.layout_strategies").horizontal_nolabel = function(
				picker,
				max_columns,
				max_lines,
				layout_config
			)
				local layout = require("telescope.pickers.layout_strategies").horizontal(
					picker,
					max_columns,
					max_lines,
					layout_config
				)
				layout.results.title = ""
				if layout.preview then
					layout.preview.title = ""
				end
				return layout
			end

			require("telescope").setup(opts)
		end,
		cmd = { "Telescope" },
		keys = {
			{
				"<C-s>",
				function()
					require("telescope.builtin").find_files({ follow = true, hidden = false })
				end,
				desc = "Search files",
			},
			{
				"<leader>sH",
				function()
					require("telescope.builtin").find_files({ follow = true, hidden = true })
				end,
				desc = "Search hidden files",
			},

			{ "<C-g>", require("telescope.builtin").live_grep, desc = "Search grep" },
			{ "<leader>ss", require("telescope.builtin").grep_string, desc = "Search string under cursor" },

			{ "<leader>sh", require("telescope.builtin").man_pages, desc = "Search help (man pages)" },
			{ "<leader>sm", require("telescope.builtin").keymaps, desc = "Search keymaps" },

			{ "<leader>sy", require("telescope.builtin").lsp_workspace_symbols, desc = "Search LSP workspace symbols" },
		},
	},

	-- Zoxide (fuzzy search directories)
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("zoxide")
		end,
		keys = {
			{ "<C-z>", "<CMD>Telescope zoxide list<CR>", desc = "Search directories (zoxide)" },
		},
	},

	-- Neoclip (yank history)
	{
		"acksld/nvim-neoclip.lua",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neoclip").setup({
				history = 256,
				enable_persistent_history = true,
			})
			require("telescope").load_extension("neoclip")
		end,
		keys = {
			{ "<leader>sp", "<CMD>Telescope neoclip<CR>", desc = "Search yank clipboard" },
		},
	},
}
