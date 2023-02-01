-- Packer: NeoVim Package Manager
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap (ensure Packer is installed)

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

-- Plugin startup

require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-------------------
	-- Customization --
	-------------------

	-- Onedark Theme
	use {
		'navarasu/onedark.nvim',
		config = function()
			local onedark = require('onedark')
			onedark.setup { style = 'deep', transparent = true }
			onedark.load()
		end
	}

    -- Icons
    use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({
                color_icons = true,
            })
        end
    }

    -- Lualine
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }


	--------------
	-- Features --
	--------------

	-- Telescope (fuzzy search)
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-telescope/telescope-fzf-native.nvim', -- Use the fzf algorithm for search
		run = 'make', cond = vim.fn.executable 'make' == 1
	}

	-- Treesitter (syntax, indent, more)
	use (
		'nvim-treesitter/nvim-treesitter',
		{ run = ':TSUpdate' }
	)

	-- LSP (using lsp-zero)
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'}, -- Configures language servers
			{'williamboman/mason.nvim'}, -- Installs and updates LSPs
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'}, -- Autocompletes based on sources (bellow)
			{'hrsh7th/cmp-nvim-lsp'}, -- Data sent by the language server
			{'hrsh7th/cmp-buffer'}, -- Suggestions from current buffer
			{'hrsh7th/cmp-path'}, -- Suggestions from the filesystem
			{'saadparwaiz1/cmp_luasnip'}, -- Snippets in the suggestions
			{'hrsh7th/cmp-nvim-lua'}, -- Provides completions based on neovim lua api

			-- Snippets
			{'L3MON4D3/LuaSnip'}, -- Snippet engine
			{'rafamadriz/friendly-snippets'}, -- Provides snippets
		}
	}

    -- DAP (debugger)
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'thehamsta/nvim-dap-virtual-text', -- Adds virual text
            'rcarriga/nvim-dap-ui', -- UI for debugging
            'nvim-telescope/telescope-dap.nvim', -- Telescope functions for DAPs
            'weissle/persistent-breakpoints.nvim', -- Save breakpoints automatically
            'mfussenegger/nvim-dap-python', -- DAP for python
        }
    }
    use "jay-babu/mason-nvim-dap.nvim"

	-- Navigate using Ctrl+HJKL, compatible with tmux
	use 'christoomey/vim-tmux-navigator'

	-- Undotree (undo history)
	use 'mbbill/undotree'

	-- Git
	use 'tpope/vim-fugitive' -- Git commands in vim
	use 'tpope/vim-rhubarb' -- GitHub integrations for fugitive
	use 'lewis6991/gitsigns.nvim' -- Git blame and +/-

	-- Autosave
	use {
		'pocco81/auto-save.nvim',
		config = function()
			require("auto-save").setup {
				execution_message = {
					message = function()
						return ('🌿')
					end,
					cleaning_interval = 700,
				},
				debounce_delay = 3000,
			}
		end,
	}

    -- Copilot
    use {
        'zbirenbaum/copilot.lua',
        event = 'VimEnter',
        config = function()
            vim.defer_fn(function()
                require('copilot').setup()
            end, 100)
        end,
    }
    use {
        'zbirenbaum/copilot-cmp',
        after = {'copilot.lua'},
        config = function ()
            require('copilot_cmp').setup()
        end
    }

    -- Comments
    use {
        'numtostr/comment.nvim',
        config = function()
            require('comment').setup()
        end
    }

    -- Autoclose tags
    use {
        'm4xshen/autoclose.nvim',
        config = function()
            require('autoclose').setup{}
        end
    }

    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        tag = 'nightly',
    }

    -- Tabs
    use {
        'romgrk/barbar.nvim',
        requires = 'nvim-web-devicons'
    }

	----------
	-- Misc --
	----------

    -- Keymaps
    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('which-key').setup()
        end
    }

	-- Vim Games
	use 'theprimeagen/vim-be-good'

	-- Load configuration automatically after installing Packer
	if is_bootstrap then
	require('packer').sync()
	end
end)

-- If we are installing packer, print a message and exit
if is_bootstrap then
	print '·················'
	print 'installing packer'
	print '·················'
	return
end

-- Automatically source and recompile every time it is saved
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
	group = packer_group,
	pattern = vim.fn.expand '$MYVIMRC',
})
