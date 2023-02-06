-- Plugin setup for Lazyplugi

return {
	-------------------
	-- Customization --
	-------------------

	-- Onedark Theme
	{
		'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
		config = function()
			local onedark = require('onedark')
			onedark.setup {
                style = 'deep',
                transparent = true,
            }
			onedark.load()
		end
	},

    -- Lualine
    {
        'hoob3rt/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            options = {
                theme = 'onedark',
                component_separators = '·',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' }, right_padding = 2 },
                },
                lualine_b = {
                    { 'filename' },
                },
                lualine_c = {
                    { 'diagnostics', sources = { 'nvim_lsp' } }
                },
                lualine_x = {
                    { 'encoding', colored = true },
                    { 'filetype', colored = true },
                },
                lualine_y = {
                    { 'branch', icon = '' },
                    { 'diff', colored = true, symbols = { added = ' ', modified = '柳', removed = ' ' } },
                },
                lualine_z = {
                    { 'location', separator = { right = '' } },
                },
            },
            extensions = { 'nvim-tree', 'nvim-dap-ui', 'fugitive' }
        }
    },

	---------------------------
	-- Navigation and search --
	---------------------------

	-- Telescope (fuzzy search)
	{
		'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            {
                'acksld/nvim-neoclip.lua',
                dependencies = {
                    'kkharji/sqlite.lua', -- Persist history between sessions
                },
                opts = {
                    history = 256,
                    enable_persistent_history = true,
                }
            },
            {
                'rcarriga/nvim-notify',
                opts = {
                    background_colour = '#040c1a',
                }
            },
        },
		config = function()
			local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-w>"] = "which_key"
                        }
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = false,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                }
            }
            telescope.load_extension('fzf')
			telescope.load_extension('notify')
            telescope.load_extension('neoclip')
        end
	},

    -- Navigate using Alt+HJKL, compatible with tmux
	'christoomey/vim-tmux-navigator',

    -- File tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        tag = 'nightly',
        opts = {
            update_focused_file = { enable = true },
            git = { show_on_dirs = false },
            view = {
                signcolumn = "auto",
            },
            renderer = {
                icons = {
                    glyphs = {
                        git = {
                            unstaged = "○",
                            untracked = "✻",
                        }
                    }
                }
            },
            filters = { dotfiles = true },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            }
        }
    },

    -- Tabs
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },

    ----------
    -- Code --
    ----------

	-- Treesitter (syntax, indent, more)
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context'
        },
        opts = {
            ensure_installed = {
                "python",
                "c", "cpp", "make", "cmake", "glsl",
                "javascript", "typescript", "css", "html", "json", "yaml",
                "latex", "bibtex", "markdown",
                "java", "sql",
                "lua", "vim", "help"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {},
            },
        },
    },

	-- LSP (using lsp-zero)
	{
		'vonheikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			'neovim/nvim-lspconfig', -- Configures language servers
			'williamboman/mason.nvim', -- Installs and updates LSPs
			'williamboman/mason-lspconfig.nvim',

			-- Autocompletion
            {
                'hrsh7th/nvim-cmp', -- Autocompletes based on sources (bellow)
                dependencies = {
                    'hrsh7th/cmp-nvim-lsp', -- Data sent by the language server
                    'hrsh7th/cmp-buffer', -- Suggestions from current buffer
                    'hrsh7th/cmp-path', -- Suggestions from the filesystem
                    'saadparwaiz1/cmp_luasnip', -- Snippets in the suggestions
                    {
                        'zbirenbaum/copilot-cmp', -- Copilot completions
                        dependencies = {
                            'zbirenbaum/copilot.lua',
                            opts = {
                                cmp = {
                                    enabled = true,
                                    method = 'getCompletionsCycling',
                                },
                                suggestion = { enabled = false },
                                server_opts_overrides = {
                                    settings = {
                                        advanced = {
                                            inlineSuggestCount = 3,
                                        }
                                    }
                                },
                                filetypes = {
                                    markdown = true,
                                }
                            }
                        },
                        config = true
                    },
                },
            },

            -- Snippets
            {
                'l3mon4d3/luasnip',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                },
            },

            -- Other
            { 'folke/neodev.nvim', opts = { library = { plugins = { 'nvim-dap-ui' }, types = true } }}, --Support signature help
        },
        config = function()
            require('koala.lsp').lsp_zero()
        end
    },

    -- LSP for Java
    { 'mfussenegger/nvim-jdtls', ft = 'java' },

    -- Markdown
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        config = function()
            vim.g.mkdp_filetypes = { 'markdown' }
            vim.g.mkdp_port = '5656'
            vim.g.mkdp_browser = 'firefox'
        end,
        ft = { 'markdown' },
    },
    {
        'jakewvincent/mkdnflow.nvim',
        opts = {
            mappings = {
                MkdnEnter = {{'i', 'n', 'v'}, '<C-CR>'},
                MkdnNextLink = false,
                MkdnPrevLink = false,
                MkdnTableNextCell = false,
                MkdnTablePrevCell = false,
            }
        },
        ft = { 'markdown' },
    },

    -- Jupiter notebooks
    --[[ {
        'luk400/vim-jukit',
        ft = { 'jupyter' }
    }, ]]

    -- Autoclose tags
    {
        'windwp/nvim-autopairs',
        opts = {
            check_ts = true,
            disable_filetype = { 'TelescopePrompt', 'vim', 'NvimTree', 'dap-repl' },
        }
    },

    -- Surround tag manager
    {
        'kylechui/nvim-surround',
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "S",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
            }
        }
    },

    ---------------
    -- Debugging --
    ---------------

    -- DAP (debugger)
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui' , -- UI for debugging
            'thehamsta/nvim-dap-virtual-text', -- Virtual text for DAPs
            'mfussenegger/nvim-dap-python', -- DAP for python
            { 'weissle/persistent-breakpoints.nvim' , opts = { load_breakpoints_event = { "BufReadPost" } }}, -- Save breakpoints automatically
            {
                'nvim-telescope/telescope-dap.nvim', -- Telescope functions for DAPs
                dependencies = {
                    'nvim-telescope/telescope.nvim',
                },
                config = function()
                    require('telescope').load_extension('dap')
                end
            }
        },
        config = function()
            require('koala.dap').setup()
            require('koala.remap').dap()
        end,
        keys = { '<C-e>', '<C-b>' }
    },

    -- Overseer (task manager)
    {
        'stevearc/overseer.nvim',
        opts = {
            dap = true,
            templates = {
                'builtin',
                'ccppbuild',
                'javabuild'
            },
        },
        ft = { 'c', 'cpp', 'java', 'python' }
    },

    -----------
    -- Other --
    -----------

	-- Undotree (undo history)
	{
        'mbbill/undotree',
        cmd = { 'UndotreeToggle' },
    },

	-- Autosave
	{
		'pocco81/auto-save.nvim',
        opts = {
            execution_message = {
                message = function()
                    return ('🌿')
                end,
                cleaning_interval = 700,
            },
            debounce_delay = 3000,
        }
	},

	-- Git
	{
        'tpope/vim-fugitive', -- Git commands in vim
        dependencies = {
            'tpope/vim-rhubarb', -- GitHub integrations for fugitive
        },
        cmd = 'Git',
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true
    },

    -- Comments
    {
        'numtostr/comment.nvim',
        opts = {
            toggler = {
                line = 'tc',
                block = 'tb',
            },
            opleader = {
                line = 'tc',
                block = 'tb',
            },
        }
    },

    -- Autosave sessions
    {
        'rmagatti/auto-session',
        opts = {
            log_level = 'error',
            auto_session_suppress_dirs = { '~/', '~/Downloads', '/'},
        }
    },

    -- Keymaps
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('which-key').setup()
        end
    },

	-- Vim Games
	'theprimeagen/vim-be-good',
}
