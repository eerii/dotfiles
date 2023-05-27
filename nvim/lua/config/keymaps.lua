-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Commands with ;
map("n", ";", ":", { desc = "Commands with ;" })

-- Disable arrow keys on normal mode
map("n", "<Up>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Down>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Left>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Right>", "<nop>", { desc = "Disable arrow keys" })

-- Half page up/down with <C-d/u> with centered cursor
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- New line without comment with <C-CR>
map("i", "<C-CR>", "<CR><C-w>", { desc = "Half page down" })

-- Add lines bellow/above the cursor with Enter/Shift-Enter (also tab the line)
map("n", "<Enter>", "o<Esc>^Da", { desc = "Add line bellow" })
map("n", "<S-Enter>", "O<Esc>^Da", { desc = "Add line above" })

-- Paste without losing the buffer
map("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })

-- Copy into the system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Don't press capital Q
map("n", "Q", "<nop>", { desc = "Don't press capital Q" })

-- Redo with U
map("n", "U", "<C-r>", { desc = "Redo" })

-- Toggle mouse
map("n", "<leader>um", function()
	if vim.o.mouse == "a" then
		vim.o.mouse = ""
	else
		vim.o.mouse = "a"
	end
end, { desc = "Toggle mouse" })
