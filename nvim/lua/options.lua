require "nvchad.options"

-- autowrite files
vim.o.autowrite = true
vim.o.confirm = true

-- indentation
vim.o.tabstop = 4 -- number of spaces
vim.o.shiftwidth = 0 -- same as tabstop
vim.o.softtabstop = 0 -- same as shiftwidth
vim.o.expandtab = true -- use spaces instead of tabs

-- relative lines numbers
vim.o.relativenumber = true

-- no line wrap
vim.o.wrap = false

-- Minimum padding when scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Line padding
vim.o.linespace = 4

-- Max completion menu items
vim.o.pumheight = 5

-- Hide cmd line
vim.o.cmdheight = 0

-- Persistent undo
vim.o.undodir = vim.fn.expand("~/.local/share/nvim/undofiles")
vim.o.undofile = true
