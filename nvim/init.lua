-- Set options
require('config.set')

-- Map leader (before lazy)
vim.g.mapleader = ' '

-- Load plugins
require('config.lazy')

-- Set mappings
require('config.remap')
