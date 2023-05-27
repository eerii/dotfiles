-- Remaps
local map = vim.keymap.set

-- Commands with ;
map("n", ";", ":", { desc = "Commands with ;" })

-- Disable arrow keys on normal mode
map("n", "<Up>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Down>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Left>", "<nop>", { desc = "Disable arrow keys" })
map("n", "<Right>", "<nop>", { desc = "Disable arrow keys" })

-- Move selected lines with J/K
map("n", "J", ":m +1<CR>", { desc = "Move line down" })
map("n", "K", ":m -2<CR>", { desc = "Move line up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Half page up/down with <C-d> and <C-u>
-- Also keeps the cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Add lines bellow/above the cursor with Enter/Shift-Enter (also tab the line)
map("n", "<Enter>", "o<Esc>^Da", { desc = "Add line bellow" })
map("n", "<S-Enter>", "O<Esc>^Da", { desc = "Add line above" })

-- Search terms stay centered
map("n", "n", "nzzzv", { desc = "Search next" })
map("n", "N", "Nzzzv", { desc = "Search previous" })

-- Paste without losing the buffer
map("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })

-- Copy into the system clipboard
map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

-- Delete to the void register
map("n", "<leader>x", '"_d', { desc = "Delete to void register" })
map("v", "<leader>x", '"_d', { desc = "Delete to void register" })

-- Don't press capital Q
map("n", "Q", "<nop>", { desc = "Don't press capital Q" })

-- Map jj to <Esc>
map("i", "jj", "<Esc>", { desc = "Map jj to <Esc>" })

-- Redo with U
map("n", "U", "<C-r>", { desc = "Redo" })

-- Go to previous buffer fast
map("n", "<C-x>", "<C-^>", { desc = "Go to previous buffer" })

-- Open lazy plugin window
map("n", "<leader>L", ":Lazy<CR>", { desc = "[L]azy plugin manager" })

-- New file with nf
map("n", "<leader>nf", ":enew<CR>", { desc = "[N]ew [F]ile" })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })
map("t", "<C-v><Esc>", "<Esc>", { desc = "Send escape to terminal" })
map("t", "<D-v>", '<C-\\><C-n>"+pi', { desc = "Paste in terminal mode" })

-- Toggle line padding
map("n", "<leader>tl", function()
	if vim.o.linespace > 0 then
		vim.o.linespace = 0
	else
		vim.o.linespace = 8
	end
end, { desc = "[T]oggle [L]ine padding" })

-- Toggle mouse
map("n", "<leader>tm", function()
	if vim.o.mouse == "a" then
		vim.o.mouse = ""
	else
		vim.o.mouse = "a"
	end
end, { desc = "[T]oggle [M]ouse" })
