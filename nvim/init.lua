-- neovim config

-- global definitions
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- init lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  -- we use nvchad as the base for the config
  {
    "nvchad/nvchad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      -- load options
      require "options"
    end,
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- load autocmds
require "nvchad.autocmds"

-- load mappings
vim.schedule(function()
  require "mappings"
end)
