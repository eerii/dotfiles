-- Remaps

local map = vim.keymap.set

---------
-- Vim --
---------

-- Set <leader> to Space
vim.g.mapleader = ' '

-- Move selected lines with J/K
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Half page up/down with C-j/k (since C-d/u are remapped)
-- Also keeps the cursor centered
map('n', '<C-j>', '<C-d>zz', { desc = 'Half page down' })
map('n', '<C-k>', '<C-u>zz', { desc = 'Half page up' })

-- Search terms stay centered
map('n', 'n', 'nzzzv', { desc = 'Search next' })
map('n', 'N', 'Nzzzv', { desc = 'Search previous' })

-- Paste without losing the buffer
map('x', '<leader>p', '"_dP', { desc = 'Paste without losing buffer' })

-- Copy into the system clipboard
map('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map('n', '<leader>Y', '"+Y', { desc = 'Copy to system clipboard' })

-- Delete to the void register
map('n', '<leader>d', '"_d', { desc = 'Delete to void register' })
map('v', '<leader>d', '"_d', { desc = 'Delete to void register' })

-- Don't press capital Q
map('n', 'Q', '<nop>', { desc = 'Don\'t press capital Q' })

-- Map jj to <Esc>
map('i', 'jj', '<Esc>', { desc = 'Map jj to <Esc>' })

-- Backspace to go to previous buffer
map('n', '<BS>', '<c-^>\'”zz', { desc = 'Backspace to previous buffer' })

---------------
-- Telescope --
---------------

local telescope = require('telescope.builtin')

-- Search for files with sf (or only git files with C-s)
map('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
map('n', '<C-s>', telescope.git_files, { desc = 'Search only git files' })

-- Search for a string in the project with sp
map('n', '<leader>sp', function() telescope.grep_string({ search = vim.fn.input("Grep > ") }) end, { desc = '[S]earch [P]royect' })

-- Keymap list and search
map('n', '<leader><leader>', telescope.keymaps, { desc = 'Search mappings' })
map('n', '<leader>sc', telescope.commands, { desc = '[S]earch [C]ommands' })

-- Neoclip (clipboard manager)
map('n', '<C-c>', ':Telescope neoclip<CR>', { desc = 'Clipboard manager' })

---------------
-- File tree --
---------------

-- Toggle file tree with C-t
map('n', '<C-t>', ':NvimTreeToggle<CR>', { desc = 'View [T]ree' })

------------------
-- Undo history --
------------------

-- Show undo tree with C-u
map('n', '<C-u>', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree history' })

---------
-- LSP --
---------

local lsp = require('lsp-zero')

lsp.on_attach(function(_, bufnr)
    -- Show diagnostics with d and next/previous with ]d/[d
    map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'LSP [D]iagnostics', buffer = bufnr })
    map('n', '[d', vim.diagnostic.goto_next, { desc = 'LSP next [D]iagnostic', buffer = bufnr })
    map('n', ']d', vim.diagnostic.goto_prev, { desc = 'LSP previous [D]iagnostic', buffer = bufnr })

    -- Show references with C-r
    map('n', '<C-r>', vim.lsp.buf.references, { desc = 'LSP [R]eferences', buffer = bufnr })

    -- Hover and info with C-h and h
    map('n', '<leader>h', vim.lsp.buf.signature_help, { desc = 'LSP [H]over signature help', buffer = bufnr })
    map('n', '<C-h>', vim.lsp.buf.hover, { desc = 'LSP [H]over info', buffer = bufnr })

    -- Rename with C-n
    map('n', '<C-n>', vim.lsp.buf.rename, { desc = 'LSP re[N]ame', buffer = bufnr })

    -- Go to definition with C-d and implementation with C-D
    map('n', '<C-d>', vim.lsp.buf.definition, { desc = 'LSP [D]efinition', buffer = bufnr })
    map('n', '<C-D>', vim.lsp.buf.implementation, { desc = 'LSP [D]efinition implementation', buffer = bufnr })

    -- Code actions with ca
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP [C]ode [A]ctions', buffer = bufnr })
end)

-----------
-- Debug --
-----------

local dap = require('dap')
local dapui = require('dapui')
local pbr = require('persistent-breakpoints.api')

-- Toggle breakpoints with C-b and conditional breakpoints with C-B
map('n', '<C-b>', pbr.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
map('n', '<C-B>', pbr.set_conditional_breakpoint, { desc = 'Conditional [B]reakpoint' })

-- Delete all breakpoints with dbr
map('n', '<leader>dbr', pbr.clear_all_breakpoints, { desc = 'Clear all [Br]eakpoints' })

-- Toggle debug UI with ps
map('n', '<leader>et', dapui.toggle, { desc = 'Toggle De[b]ug UI' })

-- Start/continue debugging with C-e and stop with C-E
map('n', '<C-e>', dap.continue, { desc = 'Continue debug [E]xecution' })
map('n', '<C-E>', dap.terminate, { desc = 'Terminate debug [E]xecution' })

-- Step into/out/over with i/o/u
map('n', '<leader>i', dap.step_into, { desc = 'Debug step [I]nto' })
map('n', '<leader>o', dap.step_over, { desc = 'Debug step [O]ver' })
map('n', '<leader>u', dap.step_out, { desc = 'Debug step [U]p (out)' })

-- Run to cursor with r
map('n', '<leader>r', dap.run_to_cursor, { desc = 'Debug [R]un to cursor' })

-- Goto with g
map('n', '<leader>g', dap.goto_, { desc = 'Debug [G]oto' })

-- Start debugging lua
map('n', '<leader>el', function()
    require('osv').launch({port = 8086})
end, { desc = 'Debug [L]ua' })

-------------
-- Tab bar --
-------------

-- Move between tabs with Alt-Left/Right
map('n', '<M-Left>', '<Cmd>BufferPrevious<CR>', { desc = 'Tab previous' })
map('n', '<M-Right>', '<Cmd>BufferNext<CR>', { desc = 'Tab next' })

-- Close tab with tc/tco
map('n', '<leader>tc', '<Cmd>BufferClose<CR>', { desc = '[T]ab [C]lose' })
map('n', '<leader>tco', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = '[T]ab [C]lose [O]ther' })

-- Move tabs with Alt-Up/Down
map('n', '<M-Up>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Tab move previous' })
map('n', '<M-Down>', '<Cmd>BufferMoveNext<CR>', { desc = 'Tab move next' })

-- Go to tab with t1-9
map('n', '<leader>t1', '<Cmd>BufferGoto 1<CR>', { desc = '[T]ab go to [1]' })
map('n', '<leader>t2', '<Cmd>BufferGoto 2<CR>', { desc = '[T]ab go to [2]' })
map('n', '<leader>t3', '<Cmd>BufferGoto 3<CR>', { desc = '[T]ab go to [3]' })
map('n', '<leader>t4', '<Cmd>BufferGoto 4<CR>', { desc = '[T]ab go to [4]' })
map('n', '<leader>t5', '<Cmd>BufferGoto 5<CR>', { desc = '[T]ab go to [5]' })
map('n', '<leader>t6', '<Cmd>BufferGoto 6<CR>', { desc = '[T]ab go to [6]' })
map('n', '<leader>t7', '<Cmd>BufferGoto 7<CR>', { desc = '[T]ab go to [7]' })
map('n', '<leader>t8', '<Cmd>BufferGoto 8<CR>', { desc = '[T]ab go to [8]' })
map('n', '<leader>t9', '<Cmd>BufferGoto 9<CR>', { desc = '[T]ab go to [9]' })

