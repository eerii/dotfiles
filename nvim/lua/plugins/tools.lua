-- Tools
-- Assorted helper plugins

return {
    -- Tmux navigator: Navigate vim/tmux panes using C+HJKL
	{
        'christoomey/vim-tmux-navigator',
        keys = {
            { '<C-h>', ':TmuxNavigateLeft<CR>', desc = 'Tmux navigate left' },
            { '<C-j>', ':TmuxNavigateDown<CR>', desc = 'Tmux navigate down' },
            { '<C-k>', ':TmuxNavigateUp<CR>', desc = 'Tmux navigate up' },
            { '<C-l>', ':TmuxNavigateRight<CR>', desc = 'Tmux navigate right' },
            { '<C-g>', ':TmuxNavigatePrevious<CR>', desc = 'Tmux navigate previous' },
        }
    },

    -- Autosave: Save files when changes are made
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
        keys = { { '<leader>u', ':UndotreeToggle<CR>', desc = 'Toggle [U]ndo Tree' } }
    },
}
