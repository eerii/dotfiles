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
vim.o.numberwidth = 3
vim.o.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"

-- Line padding
vim.o.linespace = 4

-- Hide cmd line
vim.o.cmdheight = 0

-- Set termgui colors
vim.o.termguicolors = true

-- Terminal shell
vim.g.shell = "/bin/fish"

-- Disable netrw banner
vim.g.netrw_banner = 0

-- Indent lines
-- vim.opt.list = true
-- vim.opt.listchars = { leadmultispace = "│ ", multispace = "│ ", tab = "│ " }

-- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undofiles")
vim.opt.undofile = true

-- Diagnostics
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
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Plantuml filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "plantuml filetype",
	pattern = { "*.puml", "*.uml" },
	callback = function(opts)
		---@diagnostic disable-next-line: inject-field
		vim.bo[opts.buf].filetype = "plantuml"
	end,
})
