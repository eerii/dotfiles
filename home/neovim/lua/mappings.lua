require("nvchad.mappings")

local map = vim.keymap.set

-- general

map("n", ";", ":", { desc = "Enter cmd mode with ;" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
map("n", "Q", "<nop>", { desc = "Don't press capital Q" })

map("n", "n", "nzzzv", { desc = "Search next (centered)" })
map("n", "N", "Nzzzv", { desc = "Search previous (centered)" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<C-x>", "<C-^>", { desc = "Go to previous buffer" })

map("i", "<C-CR>", "<CR><C-U>", { desc = "New line without comment" })

map("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without losing buffer" })

map("n", "U", "<C-r>", { desc = "Redo" })

-- lsp

map("n", "ge", vim.diagnostic.open_float, { desc = "LSP diagnostics" })
map({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- movement

require("smart-splits").setup()
local ss = require("smart-splits")
map("n", "<C-h>", ss.move_cursor_left, { desc = "Move cursor left" })
map("n", "<C-j>", ss.move_cursor_down, { desc = "Move cursor down" })
map("n", "<C-k>", ss.move_cursor_up, { desc = "Move cursor up" })
map("n", "<C-l>", ss.move_cursor_right, { desc = "Move cursor right" })
map("n", "<C-\\>", ss.move_cursor_previous, { desc = "Move cursor previous" })
map("n", "<leader>mh", ss.swap_buf_left, { desc = "Swap buffer left" })
map("n", "<leader>mj", ss.swap_buf_down, { desc = "Swap buffer down" })
map("n", "<leader>mk", ss.swap_buf_up, { desc = "Swap buffer up" })
map("n", "<leader>ml", ss.swap_buf_right, { desc = "Swap buffer right" })
map("n", "<C-S-h>", ss.resize_left, { desc = "Resize left" })
map("n", "<C-S-j>", ss.resize_down, { desc = "Resize down" })
map("n", "<C-S-k>", ss.resize_up, { desc = "Resize up" })
map("n", "<C-S-l>", ss.resize_right, { desc = "Resize right" })

-- neovide

if vim.g.neovide then
	-- ctrl c and ctrl v copy paste
	map("x", "<C-c>", "<C-v>y", { desc = "Copy to clipboard" })
	map("n", "<C-v>", "k+p", { desc = "Paste from clipboard" })
	map("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })

	-- on the terminal, map super+c to ctrl+c
	map("t", "<D-c>", "<C-c>", { desc = "Stop process" })
end
