return {
	-- Autosave files when changes are made
	{
		"okuuva/auto-save.nvim",
		opts = {
			debounce_delay = 1000,
			execution_message = {
				enabled = false,
			},
			condition = function(buf)
				local fn = vim.fn

				-- Don't save for special-buffers
				if fn.getbufvar(buf, "&buftype") ~= "" then
					return false
				end
				return true
			end,
		},
		event = { "InsertLeave", "TextChanged" },
		keys = {
			{ "<leader>ta", "<CMD>ASToggle<CR>", desc = "Toggle auto-save" },
		},
	},

	-- Undo history
	{
		"mbbill/undotree",
		keys = { { "<leader>su", "<CMD>UndotreeToggle<CR>", desc = "Search undo tree" } },
	},

	-- Better jump
	{
		"folke/flash.nvim",
		opts = {
			label = {
				uppercase = false,
				rainbow = {
					enabled = true,
				},
			},
		},
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter search",
			},
		},
	},

	-- Toggle comments
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment = "gc",
					textobject = "gc",
					comment_line = "gcc",
				},
			})
		end,
		event = "VeryLazy",
	},

	-- Trim trailspace
	{
		"echasnovski/mini.trailspace",
		config = function()
			require("mini.trailspace").setup()
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("mini.trailspace").trim()
				end,
				desc = "Trim trailspace",
			},
		},
	},

	-- Zen mode and pencil
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"folke/twilight.nvim",
			"preservim/vim-pencil",
		},
		opts = {
			window = {
				backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				width = 100,
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
					linebreak = true, -- break whole words
				},
			},
		},
		keys = {
			{ "<leader>z", "<CMD>ZenMode<CR><CMD>TogglePencil<CR>", desc = "Zen mode" },
			{ "<leader>w", "<CMD>TogglePencil<CR>", desc = "Wrap" },
		},
	},
}
