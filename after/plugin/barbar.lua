-- Move between tabs with tp/tn
vim.keymap.set('n', '<leader>tp', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = '[T]ab [P]revious' })
vim.keymap.set('n', '<leader>tn', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = '[T]ab [N]ext' })

-- Close tab with tc/tco
vim.keymap.set('n', '<leader>tc', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<leader>tco', '<Cmd>BufferCloseAllButCurrent<CR>', { noremap = true, silent = true, desc = '[T]ab [C]lose [O]ther' })

-- Move tabs with tmp/tmn
vim.keymap.set('n', '<leader>tmp', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = '[T]ab [M]ove [P]revious' })
vim.keymap.set('n', '<leader>tmn', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = '[T]ab [M]ove [N]ext' })

-- Go to tab with t1-9
vim.keymap.set('n', '<leader>t1', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 1' })
vim.keymap.set('n', '<leader>t2', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 2' })
vim.keymap.set('n', '<leader>t3', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 3' })
vim.keymap.set('n', '<leader>t4', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 4' })
vim.keymap.set('n', '<leader>t5', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 5' })
vim.keymap.set('n', '<leader>t6', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 6' })
vim.keymap.set('n', '<leader>t7', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 7' })
vim.keymap.set('n', '<leader>t8', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 8' })
vim.keymap.set('n', '<leader>t9', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = '[T]ab [G]o to 9' })

