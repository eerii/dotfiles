-- Vim Options

-- Autowrite files
vim.o.autowrite = true
vim.o.confirm = true

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

-- Incremental search
vim.o.incsearch = true
vim.o.hlsearch = false

-- Minimum padding when scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 4

-- Always show the sign column
vim.o.signcolumn = "yes"

-- Line padding
vim.o.linespace = 4

-- Hide cmd line
vim.o.cmdheight = 0

-- Set termgui colors
vim.o.termguicolors = true

-- Terminal zsh
vim.g.shell = "/bin/zsh"

-- Disable netrw banner
vim.g.netrw_banner = 0

-- Diagnostics
vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	float = { focusable = true },
})

-- Plantuml filetype
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
	desc = "plantuml filetype",
	pattern = {"*.puml", "*.uml"},
	callback = function (opts)
		vim.bo[opts.buf].filetype = "plantuml"
    end,
})
