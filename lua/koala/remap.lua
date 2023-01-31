-- Remaps

-- Set <leader> to Space
vim.g.mapleader = " "

-- pv: Go to the file explorer view
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = '[F]ile [V]iew' })
