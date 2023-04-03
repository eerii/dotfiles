return {
    -- Autosave files when changes are made
    {
		'pocco81/auto-save.nvim',
        opts = {
            execution_message = {
                message = '',
                cleaning_interval = 700,
            },
            debounce_delay = 3000,
            trigger_events = {"InsertLeave", "TextChanged"}, condition = function(buf)
                if vim.fn.getbufvar(buf, "&modifiable") == 0 then
                    return false
                end
                local utils = require("auto-save.utils.data")
                if not utils.not_in(vim.fn.getbufvar(buf, "&filetype"), {"sql"}) then
                    return false
                end
                return true
            end
        },
        event = 'InsertLeavePre'
	},

    -- Undotree (undo history)
	{
        'mbbill/undotree',
        keys = { { '<C-u>', ':UndotreeToggle<CR>', desc = 'Toggle [U]ndo Tree' } }
    },

    -- Load local neovim configuration
    {
        'klen/nvim-config-local',
        opts = {
            config_files = { '.nvim.lua' }
        },
        event = 'VimEnter'
    },
}