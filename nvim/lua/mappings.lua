require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-- unmap some of nvchad keymaps

unmap("n", "<leader>lf")
unmap("n", "<leader>th")
unmap("n", "<leader>fw")
unmap("n", "<leader>fb")
unmap("n", "<leader>fh")
unmap("n", "<leader>fo")
unmap("n", "<leader>fz")
unmap("n", "<leader>ff")
unmap("n", "<leader>fa")
unmap("n", "<leader>cm")
unmap("n", "<leader>cc")
unmap("n", "<leader>pt")
unmap("n", "<leader>q")
unmap("n", "<leader>h")
unmap("n", "<leader>v")
unmap("n", "<C-c>")
unmap("n", "<C-s>")

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
