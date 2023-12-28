-- Remaps
local map = vim.keymap.set

-- Commands with ;
map("n", ";", ":", { desc = "Commands with ;" })

-- Move selected lines with J/K
map("n", "J", "<CMD>m +1<CR>", { desc = "Move line down" })
map("n", "K", "<CMD>m -2<CR>", { desc = "Move line up" })
map("v", "J", "<CMD>m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", "<CMD>m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Half page up/down with <C-d> and <C-u>
-- Also keeps the cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Move between windows with <C-hjkl>
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- New line without comment in insert mode
map("i", "<C-CR>", "<CR><C-U>", { desc = "New line without comment" })

-- Search terms stay centered
map("n", "n", "nzzzv", { desc = "Search next" })
map("n", "N", "Nzzzv", { desc = "Search previous" })

-- Paste
map("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste in insert" })

-- Copy into the system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to system clipboard" })

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
map("n", "<leader>L", "<CMD>Lazy<CR>", { desc = "Lazy plugin manager" })

-- New file with nf
map("n", "<leader>n", "<CMD>enew<CR>", { desc = "New file" })

-- Toggle line wrap
map("n", "<leader>w", "<CMD>set wrap!<CR>", { desc = "Toggle line wrap" })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })
map("t", "<M-c>", "<Esc>", { desc = "Send escape to terminal" })
map("t", "<C-v>", '<C-\\><C-n>"+pi', { desc = "Paste in terminal mode" })
