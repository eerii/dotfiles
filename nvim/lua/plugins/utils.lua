return {
    -- autosave files
    {
		"okuuva/auto-save.nvim",
		opts = {
			debounce_delay = 1000,
			execution_message = {
				enabled = false,
			},
			condition = function(buf)
				local fn = vim.fn
				return fn.getbufvar(buf, "&buftype") == ""
			end,
		},
		event = { "InsertLeave", "TextChanged" },
		keys = {
			{ "<leader>ts", "<CMD>ASToggle<CR>", desc = "Toggle auto-save" },
		},
	},
}
