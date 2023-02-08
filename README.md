# dotfiles 🌿

my tiny dotfile setup

## contents

- zsh
    - oh-my-zsh
    - powerlevel10k
- tmux
- [neovim](#neovim)
    - [plugins](#plugins)
        - [customization](#customization)
        - [navigation and search](#navigation-and-search)
        - [code](#code)
        - [debugging](#debugging)
        - [other](#other)
    - [important keybindings](#important-keybindings)

<img width="550" alt="neovim" src="https://user-images.githubusercontent.com/22449369/217314340-8e948cc9-386c-497e-a47c-2f8ca16254be.png">

## neovim

### plugins

- [lazy](https://github.com/folke/lazy.nvim): plugin manager

#### customization

- [onedark](https://github.com/navarasu/onedark.nvim): color theme
- [lualine](https://github.com/hoob3rt/lualine.nvim): bottom bar customization
- [nvim-notify](https://github.com/rcarriga/nvim-notify): beautiful notifications

#### navigation and search

- [telescope](https://github.com/nvim-telescope/telescope.nvim): fuzzy finder (and much more)
    - [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim): better search with fzf
    - [neoclip](https://github.com/acksld/nvim-neoclip.lua): clipboard manager
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator): navigate between tmux windows
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lue): file explorer
- [barbar](romgrk/barbar.nvim): show opened files on tabline

#### code

- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter): better syntax highlighting
- [lsp-zero](https://github.com/vonheikemen/lsp-zero.nvim): simple lsp configuration
    - [mason](https://github.com/williamboman/mason.nvim): installs and updates lsps
    - [nvim-cmp](https://github.com/hrsh4th/nvim-cmp): autocomplete based on sources
    - [luasnip](https://github.com/l3mon4d3/luasnip) and [friendly-snippets](https://github.com/rafamadriz/friendly-snippets): provides autocompletion snippters
    - [copilot.lua](https://github.com/zbirenbaum/copilot.lua) and [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp): github copilot support
    - [neodev](https://github.com/folke/neodev.nvim): lua neovim plugin development
    - [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls): lsp and dap for java
- [markdown-preview](https://github.com/iamcco/markdown-preview): preview markdown in browser
- [mkdnflow](https://github.com/jakewvincent/mkdnflow.nvim): several tools for markdown
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs): automatically close quotes or brackets
- [nvim-surround](https://github.com/kylechui/nvim-surround): add, remove and change surrounding quotes or brackets
- [dadbod](https://github.com/tpope/vim-dadbod): database queries

#### debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap): debug adapter provider support
    - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): ui for debugging
    - [nvim-dap-virtual-text](https://github.com/thehamsta/nvim-dap-virtual-text): adds virtual text 
    - [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python): preconfigured dap for python
- [overseer](https://github.com/stevearc/overseer.nvim): task runner that integrates with nvim-dap

#### other
- [undotree](https://github.com/mbbill/undotree): see undo history
- [autosave](https://github.com/pocco81/auto-save.nvim): save file continuolsy
- [vim-fugitive](https://github.com/tpope/vim-fugitive) and [vim-rhubarb](https://github.com/tpope/vim-rhubarb): git and github commands
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): show git diff in file
- [comment](https://github.com/numtostr/comment.nvim): toggle comment lines and blocks
- [auto-session](https://github.com/rmagatti/auto-session): save and reload neovim sessions
- [which-key](https://github.com/folke/which-key.nvim): show keybindings
- [vim-be-good](https://github.com/theprimeagen/vim-be-good): games to learn vim

### important keybindings

- todo
