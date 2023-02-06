-- Remaps

local map = vim.keymap.set

---------
-- Vim --
---------

-- Move selected lines with J/K
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Half page up/down with C-j/k (since C-d/u are remapped)
-- Also keeps the cursor centered
map('n', '<C-j>', '<C-d>zz', { desc = 'Half page down' })
map('n', '<C-k>', '<C-u>zz', { desc = 'Half page up' })

-- Add lines bellow/above the cursor with Enter/Shift-Enter
map('n', '<Enter>', 'o<Esc>', { desc = 'Add line bellow' })
map('n', '<S-Enter>', 'O<Esc>', { desc = 'Add line above' })

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
map('n', '<leader>x', '"_d', { desc = 'Delete to void register' })
map('v', '<leader>x', '"_d', { desc = 'Delete to void register' })

-- Don't press capital Q
map('n', 'Q', '<nop>', { desc = 'Don\'t press capital Q' })

-- Map jj to <Esc>
map('i', 'jj', '<Esc>', { desc = 'Map jj to <Esc>' })

-- Backspace to go to previous buffer
map('n', '<BS>', '<c-^>\'”zz', { desc = 'Backspace to previous buffer' })

-- Redo with U
map('n', 'U', '<C-r>', { desc = 'Redo' })

---------------
-- Telescope --
---------------

local telescope = require('telescope.builtin')

-- Search for files (or only git files)
map('n', '<C-s>', telescope.find_files, { desc = 'Search files' })
map('n', '<leader>sf', telescope.git_files, { desc = '[S]earch only git [F]iles' })

-- Live grep and search string
map('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch [G]rep' })
map('n', '<leader>ss', telescope.grep_string, { desc = '[S]earch [S]tring' })

-- Keymap, command and vim options
map('n', '<leader>sm', telescope.keymaps, { desc = '[S]earch [M]appings' })
map('n', '<leader>sc', telescope.commands, { desc = '[S]earch [C]ommands' })
map('n', '<leader>so', telescope.vim_options, { desc = '[S]earch [O]ptions' })

-- Search help
map('n', '<leader>sh', telescope.man_pages, { desc = '[S]earch [H]elp' })

-- Neoclip (clipboard manager)
map('n', '<C-p>', ':Telescope neoclip<CR>', { desc = 'Clipboard manager' })

-- Treesitter
map('n', '<C-f>', telescope.treesitter, { desc = '[Tr]eesitter (Function, variables)' })

---------------
-- File tree --
---------------

-- Toggle file tree
map('n', '<C-t>', ':NvimTreeToggle<CR>', { desc = 'View [T]ree' })

--------------------
-- Tmux navigator --
--------------------
map('n', '<M-h>', ':TmuxNavigateLeft<CR>', { desc = 'Tmux navigate left' })
map('n', '<M-j>', ':TmuxNavigateDown<CR>', { desc = 'Tmux navigate down' })
map('n', '<M-k>', ':TmuxNavigateUp<CR>', { desc = 'Tmux navigate up' })
map('n', '<M-l>', ':TmuxNavigateRight<CR>', { desc = 'Tmux navigate right' })
map('n', '<M-H>', ':TmuxNavigatePrevious<CR>', { desc = 'Tmux navigate previous' })

------------------
-- Undo history --
------------------

-- Show undo tree with C-u
map('n', '<C-u>', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree history' })

---------
-- LSP --
---------

-- Show diagnostics with d and next/previous with ]d/[d
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'LSP [D]iagnostics' })
map('n', '[d', vim.diagnostic.goto_next, { desc = 'LSP next [D]iagnostic' })
map('n', ']d', vim.diagnostic.goto_prev, { desc = 'LSP previous [D]iagnostic' })
map('n', '<leader>da', telescope.diagnostics, { desc = 'LSP [D]iagnostics [A]ll' })

-- Show references
map('n', '<C-r>', telescope.lsp_references, { desc = 'LSP [R]eferences' })

-- Hover and info
map('n', '<C-h>', vim.lsp.buf.signature_help, { desc = 'LSP [H]over function signature help' })
map('n', '<leader>h', vim.lsp.buf.hover, { desc = 'LSP [H]over info' })

-- Incoming and outgoing calls
map('n', '<leader>ci', telescope.lsp_incoming_calls, { desc = 'LSP [I]ncoming [C]alls' })
map('n', '<leader>co', telescope.lsp_outgoing_calls, { desc = 'LSP [O]utgoing [C]alls' })

-- Symbols (workspace and document) and type definitions
map('n', '<leader>sd', telescope.lsp_document_symbols, { desc = 'LSP [S]ymbols [D]ocument' })
map('n', '<leader>sw', telescope.lsp_workspace_symbols, { desc = 'LSP [S]ymbols [W]orkspace' })
map('n', '<leader>st', telescope.lsp_type_definitions, { desc = 'LSP [S]ymbols [T]ype definitions' })

-- Rename
map('n', '<C-n>', vim.lsp.buf.rename, { desc = 'LSP re[N]ame' })

-- Go to definition with and implementation
map('n', '<C-d>', telescope.lsp_definitions, { desc = 'LSP [D]efinition' })
map('n', '<leader>gd', vim.lsp.buf.implementation, { desc = 'LSP [D]efinition implementation' })

-- Code actions with ca
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP [C]ode [A]ctions' })

-- Format buffer
map('n', '<leader>ff', vim.lsp.buf.format, { desc = 'LSP [F]ormat [F]ile' })

-----------
-- Debug --
-----------

local dap_keymap = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local pbr = require('persistent-breakpoints.api')
    local dap_conf = require('koala.dap')

    -- Toggle breakpoints and conditional breakpoints
    map('n', '<C-b>', pbr.toggle_breakpoint, { desc = 'DAP Toggle [B]reakpoint' })
    map('n', '<leader>dapcb', pbr.set_conditional_breakpoint, { desc = '[DAP] [C]onditional [B]reakpoint' })

    -- Delete all breakpoints with
    map('n', '<leader>dapdb', pbr.clear_all_breakpoints, { desc = '[DAP] [D]elete all [B]reakpoints' })

    -- Continue/stop debugging (also toggle the debug interface)
    map('n', '<C-c>', function()
        if dap.session() then
            dap.continue()
        else
            vim.cmd('normal! <C-c>')
        end
    end, { desc = 'DAP [C]ontinue debug' })
    map('n', '<C-q>', function()
        if dap.session() then
            dap.terminate()
        end
        dapui.toggle()
    end, { desc = 'DAP [Q]uit debug (and toggle UI)' })
    map('n', '<leader>dapt', dapui.toggle, { desc = 'DAP Toggle debug UI' })

    -- Step into/out/over with C-i/o/u
    map('n', '<C-i>', dap.step_into, { desc = 'DAP [I]n debug step' })
    map('n', '<leader>dapo', dap.step_out, { desc = '[DAP] [O]ut debug step' })
    map('n', '<leader>dapu', dap.step_over, { desc = '[DAP] [U]p debug step (over)' })

    -- Run to cursor
    map('n', '<leader>dapc', dap.run_to_cursor, { desc = '[DAP] run to [C]ursor' })

    -- Goto
    map('n', '<leader>dapg', dap.goto_, { desc = '[DAP] [G]oto' })

    -- Start debugging c++/lua/python C-e
    local file_exists = function(name)
        local f = io.open(name, "r")
        return f ~= nil and io.close(f)
    end

    map('n', '<C-e>', function()
        if vim.bo.filetype == 'c' then
            -- If there is a makefile
            if file_exists(vim.fn.expand('%:p:h') .. '/makefile') then
                dap.run(dap_conf.config.make)
            else
                dap.run(dap_conf.config.ccpp)
            end
        elseif vim.bo.filetype == 'cpp' then
            dap.run(dap_conf.config.ccpp)
        elseif vim.bo.filetype == 'python' then
            dap.run(dap_conf.config.python)
        elseif vim.bo.filetype == 'java' then
            dap.run(dap_conf.config.java)
        end
    end, { desc = 'Start debugging' })
end

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

---------
-- Git --
---------

map('n', '<leader>gs', telescope.git_status, { desc = '[G]it [S]tatus' })
map('n', '<leader>gb', telescope.git_branches, { desc = '[G]it [B]ranches' })
map('n', '<leader>gc', telescope.git_commits, { desc = '[G]it [C]ommits' })

require('gitsigns').on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function gmap(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    gmap('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { desc = 'Next git change' })

    gmap('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { desc = 'Previous git change' })

    -- Toggle deleted lines
    gmap('n', '<leader>gt', gs.toggle_deleted, { desc = '[G]it [T]oggle deleted' })

    -- Reset or stage hunk
    gmap({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = '[G]it [R]eset hunk' })
    gmap({'n', 'v'}, '<leader>ga', ':Gitsigns stage_hunk<CR>', { desc = '[G]it [A]dd hunk' })

    -- Select the entire hunk
    gmap({'o', 'x'}, 'ih', gs.select_hunk, { desc = '[G]it select hunk' })

    -- View the changes
    gmap('n', '<leader>gv', gs.preview_hunk_inline, { desc = '[G]it [V]iew hunk' })
end

--------------
-- Markdown --
--------------

map('n', '<leader>md', '<Plug>MarkdownPreviewToggle', { desc = '[M]ark[d]own preview toggle' })


return {
    dap = dap_keymap,
}
