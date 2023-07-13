return {
	-- Telescope
	-- https://github.com/nvim-telescope/telescope.nvim
	-- Fuzzy finder and picker, powers many other utilities
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jvgrootveld/telescope-zoxide",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"acksld/nvim-neoclip.lua",
				dependencies = {
					"kkharji/sqlite.lua",
				},
				config = function()
					require("neoclip").setup({
						history = 256,
						enable_persistent_history = true,
					})
					require("telescope").load_extension("neoclip")
					require("telescope").load_extension("zoxide")
				end,
			},
			{
				"theprimeagen/harpoon",
				config = function()
					require("harpoon").setup()
					require("telescope").load_extension("harpoon")
				end,
				dependencies = { "nvim-lua/plenary.nvim" },
				keys = function()
					local has_ui, ui = pcall(require, "harpoon.ui")
					if not has_ui then
						return {}
					end
					local has_mark, mark = pcall(require, "harpoon.mark")
					if not has_mark then
						return {}
					end
					local has_cmd, cmd = pcall(require, "harpoon.cmd-ui")
					if not has_cmd then
						return {}
					end

					return {
						{ "<C-m>", mark.add_file, desc = "Add harpoon [M]ark" },
						{ "<C-n>", ui.toggle_quick_menu, desc = "Toggle harpoon [N]avigation menu" },
						{ "<C-,>", ui.nav_next, desc = "Navigate to next harpoon mark" },
						{ "<C-.>", ui.nav_prev, desc = "Navigate to previous harpoon mark" },
						{
							"<C-1>",
							function()
								ui.nav_file(1)
							end,
							desc = "Navigate to harpoon [T]ag 1",
						},
						{
							"<C-2>",
							function()
								ui.nav_file(2)
							end,
							desc = "Navigate to harpoon [T]ag 2",
						},
						{
							"<C-3>",
							function()
								ui.nav_file(3)
							end,
							desc = "Navigate to harpoon [T]ag 3",
						},
						{
							"<C-4>",
							function()
								ui.nav_file(4)
							end,
							desc = "Navigate to harpoon [T]ag 4",
						},
						{
							"<C-5>",
							function()
								ui.nav_file(5)
							end,
							desc = "Navigate to harpoon [T]ag 5",
						},
						{
							"<C-6>",
							function()
								ui.nav_file(6)
							end,
							desc = "Navigate to harpoon [T]ag 6",
						},
						{
							"<C-7>",
							function()
								ui.nav_file(7)
							end,
							desc = "Navigate to harpoon [T]ag 7",
						},
						{
							"<C-8>",
							function()
								ui.nav_file(8)
							end,
							desc = "Navigate to harpoon [T]ag 8",
						},
						{
							"<C-9>",
							function()
								ui.nav_file(9)
							end,
							desc = "Navigate to harpoon [T]ag 9",
						},
						{ "<C-e>", cmd.toggle_quick_menu, desc = "Toggle harpoon command menu" },
					}
				end,
			},
		},
		opts = {
			defaults = {
				mappings = {
					i = { ["<C-w>"] = "which_key" },
				},
				layout_strategy = "horizontal_merged",
				layout_config = {
					prompt_position = "top",
				},
				file_ignore_patterns = {
					"lib",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = false,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				file_browser = {
					hijack_netrw = true,
				},
				zoxide = {},
			},
		},
		config = function(_, opts)
			require("telescope.pickers.layout_strategies").horizontal_merged = function(
				picker,
				max_columns,
				max_lines,
				layout_config
			)
				local layout = require("telescope.pickers.layout_strategies").horizontal(
					picker,
					max_columns,
					max_lines,
					layout_config
				)

				layout.results.title = ""
				layout.results.line = layout.results.line - 1
				layout.results.height = layout.results.height + 1

				layout.prompt.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
				layout.results.borderchars = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }

				return layout
			end

			require("telescope").setup(opts)
		end,
		cmd = { "Telescope" },
		keys = function()
			local has_telescope, telescope = pcall(require, "telescope.builtin")
			if not has_telescope then
				return {}
			end
			local has_nc, nc = pcall(require, "neoclip")
			if not has_nc then
				return {}
			end

			return {
				-- Search for files
				{
					"<C-s>",
					function()
						telescope.find_files({ follow = true, hidden = false })
					end,
					desc = "Search files",
				},
				{
					"gfh",
					function()
						telescope.find_files({ follow = true, hidden = true })
					end,
					desc = "[S]earch [H]idden [F]iles",
				},
				{ "gfg", telescope.git_files, desc = "[S]earch only git [F]iles" },

				-- Search for folders using zoxide
				{ "<C-z>", ":Telescope zoxide list<CR>", desc = "[S]earch [Z]oxide path" },

				-- Live grep and search string
				{ "<C-g>", telescope.live_grep, desc = "[S]earch [G]rep" },
				{ "<leader>s", telescope.grep_string, desc = "[S]earch [S]tring under cursor" },

				-- Keymap, command and vim options
				{ "gm", telescope.keymaps, desc = "[S]earch [M]appings" },
				{ "gc", telescope.commands, desc = "[S]earch [C]ommands" },
				{ "go", telescope.vim_options, desc = "[S]earch [O]ptions" },

				-- Buffers
				{ "gb", telescope.buffers, desc = "[S]earch [B]uffers" },

				-- Search help
				{ "gH", telescope.man_pages, desc = "[S]earch [H]elp" },

				-- Treesitter
				{ "gv", telescope.treesitter, desc = "[S]earch Treesitter [V]ariables" },

				-- Neoclip clipboard
				{ "gp", ":Telescope neoclip<CR>", desc = "[S]earch [P]aste clipboard history" },

				-- Notify history
				{ "gN", ":Telescope notify<CR>", desc = "[S]earch [N]otifications" },

				-- Git
				{ "<leader>gs", telescope.git_status, desc = "[G]it [S]tatus" },
				{ "<leader>gb", telescope.git_branches, desc = "[G]it [B]ranches" },
				{ "<leader>gc", telescope.git_commits, desc = "[G]it [C]ommits" },

				-- Diagnostics
				{ "<leader>d", telescope.diagnostics, desc = "Search [D]iagnostics" },

				-- LSP
				{ "<leader>ld", telescope.lsp_definitions, desc = "[L]SP [D]efinition" },
				{ "gR", telescope.lsp_references, desc = "LSP [R]eferences" },
				{ "gT", telescope.lsp_type_definitions, desc = "LSP [T]ype definitions" },

				{ "gI", telescope.lsp_incoming_calls, desc = "LSP [I]ncoming calls" },
				{ "gO", telescope.lsp_outgoing_calls, desc = "LSP [O]utgoing calls" },

				{ "gy", telescope.lsp_document_symbols, desc = "LSP [S]ymbols [D]ocument" },
				{ "gw", telescope.lsp_workspace_symbols, desc = "LSP [S]ymbols [W]orkspace" },

				-- Harpoon
				{ "gM", ":Telescope harpoon marks<CR>", desc = "Get harpoon [M]arks" },
			}
		end,
	},
}
