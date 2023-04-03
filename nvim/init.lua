-- Open in the first arg directory
vim.cmd([[if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif]])

-- Set options
require('config.set')

-- Map leader (before lazy)
vim.g.mapleader = ' '

-- Load plugins
require('config.lazy')

-- Set mappings
require('config.remap')

-- Neovide options
require('config.neovide')
