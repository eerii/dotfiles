return {
	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			local conf = require("nvchad.configs.telescope")

			conf.defaults.mappings = {
				n = {
					["<C-t>"] = require("trouble.sources.telescope").open,
				},
				i = {
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<Esc>"] = require("telescope.actions").close,
					["<C-t>"] = require("trouble.sources.telescope").open,
				},
			}

			return conf
		end,
		keys = {
			{
				"<C-f>",
				function()
					if vim.g.telescope_find_override then
						vim.g.telescope_find_override()
					else
						require("telescope.builtin").find_files({ follow = true, hidden = false })
					end
				end,
				desc = "Search files",
			},
			{
				"<leader>sh",
				function()
					require("telescope.builtin").find_files({ follow = true, hidden = true })
				end,
				desc = "Search hidden files",
			},
			{ "<leader>sg", require("telescope.builtin").live_grep, desc = "Search grep" },
			{ "<leader>sb", require("telescope.builtin").current_buffer_fuzzy_find, desc = "Search current buffer" },
			{
				"<leader>ss",
				require("telescope.builtin").grep_string,
				desc = "Search string under cursor",
			},
			{ "<leader>sM", require("telescope.builtin").man_pages, desc = "Search man pages" },
			{ "<leader>sH", require("telescope.builtin").help_tags, desc = "Search vim help" },
			{ "<leader>sk", require("telescope.builtin").keymaps, desc = "Search keymaps" },
			{
				"<leader>sy",
				require("telescope.builtin").lsp_workspace_symbols,
				desc = "Search LSP workspace symbols",
			},
			{ "<leader>gc", require("telescope.builtin").git_commits, desc = "Git commit log" },
			{ "<leader>gs", require("telescope.builtin").git_status, desc = "Git status" },
			{ "<leader>th", "<CMD>Telescope themes<CR>", desc = "Theme list" },
			--
		},
	},

	-- zoxide
	{
		"jvgrootveld/telescope-zoxide",
		config = function()
			require("telescope").load_extension("zoxide")
		end,
		keys = {
			{ "<C-z>", "<CMD>Telescope zoxide list<CR>", desc = "Search directories (zoxide)" },
		},
	},
}
