-- Vim Options

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

-- Minimum padding when scrolling
vim.o.scrolloff = 8

-- Fast updates
vim.o.updatetime = 50
