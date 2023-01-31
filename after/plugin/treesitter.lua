local ts = require('nvim-treesitter.configs')

ts.setup {
	-- Parsers
	ensure_installed = {
		"python",
		"c", "cpp", "make", "cmake", "glsl",
		"javascript", "typescript", "css", "html", "json", "yaml",
		"latex", "bibtex", "markdown",
		"java", "sql",
		"lua", "vim", "help" },

	-- Install options
	sync_install = false,
	auto_install = true,

	-- Highlight
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	-- Indent
	indent = {
		enable = true,
	},

	-- Incremental selection TODO
	incremental_selection = {
		enable = true,
		keymaps = {},
	},
}
