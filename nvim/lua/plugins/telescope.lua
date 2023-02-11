-- Telescope
-- https://github.com/nvim-telescope/require('telescope')nvim
-- Fuzzy finder and picker, powers many other utilities

return {
    {
		'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require('telescope').load_extension('fzf')
                end
            },
        },
        opts = {
            defaults = {
                mappings = {
                    i = { ['<C-w>'] = 'which_key' }
                },
                layout_strategy = 'horizontal',
                layout_config = {
                    prompt_position = 'top'
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = false,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
                file_browser = {
                    hijack_netrw = true,
                }
            }
        },
        config = function()
            local t = require('telescope')
            t.load_extension('neoclip') -- Already loaded on VeryLazy
            t.load_extension('notify') -- Already loaded on VeryLazy
        end,
        keys = function()
            local has_telescope, telescope = pcall(require, 'telescope.builtin')
            if (not has_telescope) then return {} end

            return {
                -- Search for files (or only git files)
                { '<C-s>', telescope.find_files, desc = 'Search files' },
                { '<leader>sf', telescope.git_files, desc = '[S]earch only git [F]iles' },

                -- Live grep and search string
                { '<leader>sg', telescope.live_grep, desc = '[S]earch [G]rep' },
                { '<leader>ss', telescope.grep_string, desc = '[S]earch [S]tring' },

                -- Keymap, command and vim options
                { '<leader>sm', telescope.keymaps, desc = '[S]earch [M]appings' },
                { '<leader>sc', telescope.commands, desc = '[S]earch [C]ommands' },
                { '<leader>so', telescope.vim_options, desc = '[S]earch [O]ptions' },

                -- Buffers
                { '<leader>sb', telescope.buffers, desc = '[S]earch [B]uffers' },

                -- Search help
                { '<leader>sh', telescope.man_pages, desc = '[S]earch [H]elp' },

                -- Treesitter
                { '<C-f>', telescope.treesitter, desc = '[Tr]eesitter (Function variables)' },

                -- Neoclip clipboard (add load extension)
                { '<leader>sp', ':Telescope neoclip<CR>', desc = '[S]earch [P]aste clipboard history' },

                -- Notify history
                { '<leader>sn', ':Telescope notify<CR>', desc = '[S]earch [N]otifications' },

                -- Git
                { '<leader>gs', telescope.git_status, desc = '[G]it [S]tatus' },
                { '<leader>gb', telescope.git_branches, desc = '[G]it [B]ranches' },
                { '<leader>gc', telescope.git_commits, desc = '[G]it [C]ommits' },

                -- Diagnostics
                { '<leader>sd', telescope.diagnostics, desc = '[S]earch [D]iagnostics' },

                -- LSP
                { 'gd', telescope.lsp_definitions, desc = 'LSP [D]efinition' },
                { 'gr', telescope.lsp_references, desc = 'LSP [R]eferences' },
                { 'gt', telescope.lsp_type_definitions, desc = 'LSP [T]ype definitions' },

                { '<leader>ci', telescope.lsp_incoming_calls, desc = 'LSP [I]ncoming [C]alls' },
                { '<leader>co', telescope.lsp_outgoing_calls, desc = 'LSP [O]utgoing [C]alls' },

                { '<leader>sy', telescope.lsp_document_symbols, desc = 'LSP [S]ymbols [D]ocument' },
                { '<leader>sw', telescope.lsp_workspace_symbols, desc = 'LSP [S]ymbols [W]orkspace' },
            }
        end
    },
    -- Replaced by oil.nvim
    --[[ {
        'nvim-telescope/telescope-file-browser.nvim',
        config = function()
            require('telescope').load_extension('file_browser')
        end,
        keys = {
            { '<C-t>', ':Telescope file_browser path=%:p:h<CR>', desc = 'Telescope file browser' },
        }
    } ]]--
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        keys = { { '<C-t>', ':Oil --float<CR>', desc = 'Oil file browser' } },
        opts = {
            keymaps = {
                ['<C-w>'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['p'] = 'actions.preview',
                ['q'] = 'actions.close',
                ['R'] = 'actions.refresh',
                ['-'] = 'actions.parent',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                ['H'] = 'actions.toggle_hidden',
            },
            view_options = { show_hidden = true },
            float = { padding = 4, max_width = 160, max_height = 40 }
        },
    }
}
