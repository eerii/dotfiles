local dap = require('dap')
local dapui = require('dapui')
local pbr = require('persistent-breakpoints')

-- DAP UI
dapui.setup{}
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
--dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
--dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

vim.keymap.set('n', '<leader>vdb', dapui.open, { desc = '[V]iew [D]ebugger', noremap = true, silent = true })
vim.keymap.set('n', '<leader>cdb', dapui.close, { desc = '[C]lose [D]ebugger', noremap = true, silent = true })

-- Language DAPs
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- Persistent breakpoints

pbr.setup{
    load_breakpoints_event = { "BufReadPost" }
}

local pbr_api = require('persistent-breakpoints.api')
vim.keymap.set('n', '<leader>bt', pbr_api.toggle_breakpoint, { desc = '[B]reakpoint [T]oggle', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bc', pbr_api.set_conditional_breakpoint, { desc = '[B]reakpoint [C]onditional', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bda', pbr_api.clear_all_breakpoints, { desc = '[B]reakpoint [D]elete [A]ll', noremap = true, silent = true })
