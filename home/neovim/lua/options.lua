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
vim.o.undodir = vim.fn.expand "~/.local/share/nvim/undofiles"
vim.o.undofile = true

-- enable per project config
vim.o.exrc = true

-- diagnostics
vim.diagnostic.config {
    underline = {
        severity = { max = vim.diagnostic.severity.INFO },
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
}

-- neovide
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9

    -- padding
    vim.g.neovide_padding_top = 24

    -- font
    vim.o.guifont = "JetBrains Mono:h14"
    vim.o.linespace = 0

    -- panels
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_shadow = true

    -- mouse and cursor
    vim.g.neovide_cursor_animation_length = 0.07
    vim.g.neovide_cursor_trail_size = 0.4

    -- remaps for system keys
    vim.g.neovide_input_use_logo = true
end
