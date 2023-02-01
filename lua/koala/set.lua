-- Vim Options

-- Terminal zsh
vim.o.shell = '/bin/zsh'

-- Indentation
vim.o.tabstop = 4 -- Number of spaces
vim.o.shiftwidth = 0 -- Same as tabstop
vim.o.softtabstop = -1 -- Same as shiftwidth
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true

-- Relative line numbers
vim.o.nu = true
vim.o.relativenumber = true

-- No line wrap
vim.o.wrap = false

-- No backups but long undos
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true

-- Incremental search
vim.o.incsearch = true
vim.o.hlsearch = false

-- Minimum padding when scrolling
vim.o.scrolloff = 8

-- Fast updates
vim.o.updatetime = 50

-- Disable netrw (to avoid conflicts with nvim-tree.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termgui colors
vim.o.termguicolors = true

-- Python 3
vim.g.python3_host_prog = '/usr/local/bin/python3.11'
