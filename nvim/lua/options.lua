require "nvchad.options"

-- autowrite files
vim.o.autowrite = true
vim.o.confirm = true

-- indentation
vim.o.tabstop = 4      -- number of spaces
vim.o.shiftwidth = 0   -- same as tabstop
vim.o.softtabstop = 0  -- same as shiftwidth
vim.o.expandtab = true -- use spaces instead of tabs

-- relative lines numbers
vim.o.relativenumber = true

-- no line wrap
vim.o.wrap = false

-- minimum padding when scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- line padding
vim.o.linespace = 4

-- max completion menu items
vim.o.pumheight = 5

-- hide cmd line
vim.o.cmdheight = 0

-- load files on changes
vim.o.autoread = true

-- persistent undo
vim.o.undodir = vim.fn.expand("~/.local/share/nvim/undofiles")
vim.o.undofile = true

-- diagnostics
vim.diagnostic.config({
    underline = {
        severity = { max = vim.diagnostic.severity.INFO },
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
})
