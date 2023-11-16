return {
	-- Improve UI (commandline, notifications)
	{
		"folke/noice.nvim",
		dependencies = {
			"muniftanjim/nui.nvim",
		},
		opts = {},
		event = "VeryLazy",
		keys = {
			{ "<leader>sn", "<CMD>Noice telescope<CR>", desc = "Search notifications" },
		},
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		opts = {
			"*",
			css = { rgb_fn = true },
		},
		event = "BufRead",
	},
}
