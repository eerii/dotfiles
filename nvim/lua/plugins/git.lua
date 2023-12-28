return {
	-- Git sign column
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "│" },
				untracked = { text = "│" },
			},
		},
		event = "BufRead",
		keys = {
			{ "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", mode = { "n", "v" }, desc = "[G]it stage hunk" },
			{ "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", mode = { "n", "v" }, desc = "[G]it reset hunk" },
			{ "<leader>gS", "<CMD>Gitsigns stage_buffer<CR>", desc = "[G]it stage buffer" },
			{ "<leader>gR", "<CMD>Gitsigns reset_buffer<CR>", desc = "[G]it reset buffer" },
			{ "<leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>", desc = "[G]it undo stage" },
			{ "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>", desc = "[G]it preview" },
			{ "<leader>gd", "<CMD>Gitsigns diffthis<CR>", desc = "[G]it diff" },
			{ "<leader>gt", "<CMD>Gitsigns toggle_deleted<CR>", desc = "[G]it toggle delete" },
			{ "ih", "<CMD>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "[G]it select hunk" },
		},
	},
}
