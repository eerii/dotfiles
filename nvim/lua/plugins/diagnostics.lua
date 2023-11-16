return {
	-- Trouble (diagnostics list)
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "bottom",
		},
		keys = {
			{ "<leader>sd", "<CMD>TroubleToggle document_diagnostics<CR>", desc = "Trouble document diagnostics" },
			{ "<leader>sD", "<CMD>TroubleToggle workspace_diagnostics<CR>", desc = "Trouble workspace diagnostics" },
			{ "<leader>sq", "<CMD>TroubleToggle quickfix<CR>", desc = "Trouble quickfix" },
			-- TODO: Add LSP lists
		},
		event = "BufRead",
	},

	-- Todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>st", "<CMD>TodoTrouble<CR>", desc = "Todo list on Trouble" },
		},
		event = "BufRead",
	},
}
