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
			{ "<leader>ua", ":ASToggle<CR>", desc = "Toggle auto-save" },
		},
	},
}
