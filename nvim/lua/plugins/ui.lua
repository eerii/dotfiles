local colors = {
	red = "#E46876",
	yellow = "#DCA561",
	green = "#76946A",
	blue = "#7E9CD8",
	magenta = "#957FB8",
}

local lualine_mode = {
	-- mode component
	function()
		return "██"
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.blue,
			i = colors.green,
			v = colors.magenta,
			[""] = colors.magenta,
			V = colors.magenta,
			c = colors.yellow,
			t = colors.blue,
		}
		-- If color in table, color, else, red
		local color = mode_color[vim.fn.mode()]
		if color == nil then
			color = colors.red
		end
		return { fg = color }
	end,
	padding = 0,
	separator = "",
}

return {
	-- Notifications
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
			render = "compact",
			timeout = 3000,
			max_height = function()
				return math.ceil(math.max(vim.opt.lines:get() / 3, 4))
			end,
		},
	},

	-- Improve UI (commandline, notifications)
	{
		"folke/noice.nvim",
		dependencies = {
			"muniftanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {},
		event = "VeryLazy",
		keys = {
			{ "<leader>sn", "<CMD>Noice telescope<CR>", desc = "Search notifications" },
		},
	},

	-- Improve UI (select, input)
	{
		"stevearc/dressing.nvim",
		opts = {},
		event = "VeryLazy",
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = "|",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {},
				lualine_b = { lualine_mode, "filename", "diagnostics" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					{
						"%3{codeium#GetStatusString()}",
						cond = function()
							return vim.fn.exists("*codeium#Accept") ~= 0
						end,
					},
					"diff",
					"progress",
				},
				lualine_z = {},
			},
			extensions = {
				"trouble",
			},
		},
		event = "VeryLazy",
	},

	-- TODO: Breadcrumbs (needs 0.10)
	{
		"Bekaboo/dropbar.nvim",
		enabled = false,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		event = "BufRead",
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
