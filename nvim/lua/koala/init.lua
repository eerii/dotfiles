-- Sets
require('koala.set')

-- Map leader (before lazy)
vim.g.mapleader = ' '

-- Lazy : Plugin manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('koala.plugins', {
    checker = { enabled = true },
    change_detection = { enabled = false },
    dev = {
        path = '~/Programacion/neovim',
        patterns = {},
        fallback = false,
    }
})

-- Mappings
require('koala.remap')

-- Autocommand to load a .nvim.lua config file from the current directory with exrc
vim.cmd([[
    augroup exrc
        autocmd!
        autocmd VimEnter * if &ft == 'vim' && filereadable('.nvim.lua') | source .nvim.lua | endif
    augroup END
]])
