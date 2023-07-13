local Util = require("lazyvim.util")

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<C-s>", Util.telescope("files", { cwd = false, follow = true }), desc = "Find files" },
		},
	},
}
