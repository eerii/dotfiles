return {
	-- Plantuml renderer
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		version = "*",
		opts = {
			renderer = {
				type = "imv",
				options = {
					dark_mode = true,
				},
			},
		},
		ft = "plantuml",
	},

	-- Pandoc renderer
	{
		"garciabarreiro/nvim-pandoc",
		dir = "~/Code/pkgs/nvim-plugins/nvim-pandoc",
		ft = { "markdown", "latex" },
		keys = {
			{
				"<leader>pd",
				function()
					vim.api.nvim_create_augroup("Pandoc", { clear = false })
					vim.api.nvim_clear_autocmds({ buffer = 0, group = "Pandoc" })
					vim.api.nvim_create_autocmd("BufWritePost", {
						group = "Pandoc",
						buffer = 0,
						callback = function()
							vim.cmd("PandocWrite")
						end,
					})
					vim.cmd("PandocRead")
				end,
				desc = "Pandoc enable",
			},
		},
	},

	-- Markdown paste image
	{
		"dfendr/clipboard-image.nvim",
		branch = "patch-1",
		ft = "markdown",
		keys = {
			{ "<leader>mi", "<CMD>PasteImg<CR>", desc = "Markdown paste image" },
		},
	},
}
