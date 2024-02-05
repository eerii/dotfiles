-- Automatically import output chunks from a jupyter notebook
-- local imb = function(e)
-- 	vim.schedule(function()
-- 		local kernels = vim.fn.MoltenAvailableKernels()
-- 		local try_kernel_name = function()
-- 			local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
-- 			return metadata.kernelspec.name
-- 		end
-- 		local ok, kernel_name = pcall(try_kernel_name)
-- 		if not ok or not vim.tbl_contains(kernels, kernel_name) then
-- 			kernel_name = nil
-- 			local venv = os.getenv("VIRTUAL_ENV")
-- 			if venv ~= nil then
-- 				kernel_name = string.match(venv, "/.+/(.+)")
-- 			end
-- 		end
-- 		if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
-- 			vim.cmd(("MoltenInit %s"):format(kernel_name))
-- 		end
-- 		vim.cmd("MoltenImportOutput")
-- 	end)
-- end
-- vim.api.nvim_create_autocmd("BufAdd", {
-- 	pattern = { "*.ipynb" },
-- 	callback = imb,
-- })

-- We have to do this as well so that we catch files opened like nvim ./hi.ipynb
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = { "*.ipynb" },
-- 	callback = function(e)
-- 		if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
-- 			imb(e)
-- 		end
-- 	end,
-- })

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

	-- Jupyter notebooks
	-- {
	-- 	"benlubas/molten-nvim",
	-- 	dependencies = {
	-- 		-- "3rd/image.nvim",
	-- 		"quarto-dev/quarto-nvim",
	-- 		{
	-- 			"gcballesteros/jupytext.nvim",
	-- 			opts = {
	-- 				style = "markdown",
	-- 				output_extension = "md",
	-- 				force_ft = "markdown",
	-- 			},
	-- 		},
	-- 	},
	-- 	build = ":UpdateRemotePlugins",
	-- 	init = function()
	-- 		vim.g.molten_wrap_output = true
	-- 		vim.g.molten_virt_text_output = true
	-- 		vim.g.molten_virt_lines_off_by_1 = true
	-- 		-- vim.g.molten_image_provider = "image.nvim"
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>me", "<CMD>MoltenEvaluateOperator<CR>", { desc = "Molten evaluate operator" } },
	-- 		{ "<leader>me", "<CMD>C-u>MoltenEvaluateVisual<CR>gv", mode = "x", { desc = "Molten evaluate visual" } },
	-- 		{ "<leader>mr", "<CMD>MoltenReevaluateCell<CR>", { desc = "Molten open output window" } },
	-- 		{ "<leader>mo", "<CMD>noautocmd MoltenEnterOutput<CR>", { desc = "Molten open output window" } },
	-- 		{ "<leader>mc", "<CMD>MoltenHideOutput<CR>", { desc = "Molten close output window" } },
	-- 		{ "<leader>md", "<CMD>MoltenDelete<CR>", { desc = "Molten delete cell" } },
	-- 		{ "<leader>ms", "<CMD>MoltenExportOutput!<CR>", { desc = "Molten export output" } },
	-- 	},
	-- },

	-- Quarto
	-- {
	-- 	"quarto-dev/quarto-nvim",
	-- 	dependencies = {
	-- 		{
	-- 			"jmbuhr/otter.nvim",
	-- 			dependencies = {
	-- 				"neovim/nvim-lspconfig",
	-- 			},
	-- 			opts = {
	-- 				buffers = {
	-- 					set_filetype = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		lspFeatures = {
	-- 			languages = { "python", "julia" },
	-- 			chunks = "all",
	-- 			diagnostics = {
	-- 				enabled = true,
	-- 				triggers = { "BufWritePost" },
	-- 			},
	-- 			completion = {
	-- 				enabled = true,
	-- 			},
	-- 		},
	-- 		codeRunner = {
	-- 			enabled = true,
	-- 			default_method = "molten",
	-- 		},
	-- 	},
	-- 	ft = { "quarto", "markdown" },
	-- },

	-- Help for keymaps
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		event = "VeryLazy",
	},

	-- Hydrate
	{
		"stefanlogue/hydrate.nvim",
		opts = {
			minute_interval = 30,
			persist_timer = true,
		},
	},
}
