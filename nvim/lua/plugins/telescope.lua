return {
    -- Telescope
    -- https://github.com/nvim-telescope/telescope.nvim
    -- Fuzzy finder and picker, powers many other utilities
    {
		'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
            'jvgrootveld/telescope-zoxide',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require('telescope').load_extension('fzf')
                end
            },
            {
                'acksld/nvim-neoclip.lua',
                dependencies = {
                    'kkharji/sqlite.lua',
                },
                config = function()
                    require('neoclip').setup {
                        history = 256,
                        enable_persistent_history = true,
                    }
                    require('telescope').load_extension('neoclip')
                    require('telescope').load_extension('zoxide')
                end
            }
        },
        opts = {
            defaults = {
                mappings = {
                    i = { ['<C-w>'] = 'which_key' }
                },
                layout_strategy = 'horizontal',
                layout_config = {
                    prompt_position = 'top'
                },
                file_ignore_patterns = {
                    'lib'
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
                },
                zoxide = {}
            }
        },
        cmd = { 'Telescope' },
        keys = function()
            local has_telescope, telescope = pcall(require, 'telescope.builtin')
            if (not has_telescope) then return {} end
            local has_nc, nc = pcall(require, 'neoclip')
            if not has_nc then return {} end

            return {
                -- Search for files
                { '<C-s>', function() telescope.find_files{ follow = true, hidden = false } end, desc = 'Search files' },
                { 'gfh', function() telescope.find_files{ follow = true, hidden = true } end, desc = '[S]earch [H]idden [F]iles' },
                { 'gfg', telescope.git_files, desc = '[S]earch only git [F]iles' },

                -- Search for folders using zoxide
                { '<C-z>', ':Telescope zoxide list<CR>', desc = '[S]earch [Z]oxide path' },

                -- Live grep and search string
                { '<C-g>', telescope.live_grep, desc = '[S]earch [G]rep' },
                { '<leader>s', telescope.grep_string, desc = '[S]earch [S]tring under cursor' },

                -- Keymap, command and vim options
                { 'gm', telescope.keymaps, desc = '[S]earch [M]appings' },
                { 'gc', telescope.commands, desc = '[S]earch [C]ommands' },
                { 'go', telescope.vim_options, desc = '[S]earch [O]ptions' },

                -- Buffers
                { 'gb', telescope.buffers, desc = '[S]earch [B]uffers' },

                -- Search help
                { 'gH', telescope.man_pages, desc = '[S]earch [H]elp' },

                -- Treesitter
                { 'gv', telescope.treesitter, desc = '[S]earch Treesitter [V]ariables' },

                -- Neoclip clipboard
                { 'gp', ':Telescope neoclip<CR>', desc = '[S]earch [P]aste clipboard history' },

                -- Notify history
                { 'gN', ':Telescope notify<CR>', desc = '[S]earch [N]otifications' },

                -- Git
                { '<leader>gs', telescope.git_status, desc = '[G]it [S]tatus' },
                { '<leader>gb', telescope.git_branches, desc = '[G]it [B]ranches' },
                { '<leader>gc', telescope.git_commits, desc = '[G]it [C]ommits' },

                -- Diagnostics
                { '<leader>d', telescope.diagnostics, desc = 'Search [D]iagnostics' },

                -- LSP
                { '<leader>ld', telescope.lsp_definitions, desc = '[L]SP [D]efinition' },
                { 'gR', telescope.lsp_references, desc = 'LSP [R]eferences' },
                { 'gT', telescope.lsp_type_definitions, desc = 'LSP [T]ype definitions' },

                { 'gI', telescope.lsp_incoming_calls, desc = 'LSP [I]ncoming calls' },
                { 'gO', telescope.lsp_outgoing_calls, desc = 'LSP [O]utgoing calls' },

                { 'gy', telescope.lsp_document_symbols, desc = 'LSP [S]ymbols [D]ocument' },
                { 'gw', telescope.lsp_workspace_symbols, desc = 'LSP [S]ymbols [W]orkspace' },
            }
        end
    }
}
