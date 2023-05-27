-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Indentation
vim.o.tabstop = 4 -- Number of spaces
vim.o.shiftwidth = 0 -- Same as tabstop
vim.o.softtabstop = -1 -- Same as shiftwidth
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true

-- No line wrap
vim.o.wrap = false

-- Minimum padding when scrolling
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- Fast updates and scrolling
vim.o.updatetime = 50

-- Terminal zsh
vim.g.shell = "/bin/zsh"

-- Python 3
vim.g.python3_host_prog = "/usr/local/bin/python3.11"
