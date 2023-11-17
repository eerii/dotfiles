return {
	-- Improve UI (commandline, notifications)
	{
		"folke/noice.nvim",
		dependencies = {
			"muniftanjim/nui.nvim",
			{ "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
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
