return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"regex",
				"rust",
				"python",
				"vim",
				"vimdoc",
				"lua",
				"markdown",
				"markdown_inline",
				"bash",
				"html",
				"css",
				"toml",
			},
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-CR>",
					node_incremental = "<C-CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
			highlight = {
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
						["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
						["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["as"] = { query = "@scope", desc = "Select language scope" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
					},
					swap_previous = {
						["<leader>A"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
					},
				},
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "Next function start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]s"] = { query = "@scope", desc = "Next scope start" },
						["]z"] = { query = "@fold", desc = "Next fold start" },
					},
					goto_next_end = {
						["]F"] = { query = "@function.outer", desc = "Next function end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]S"] = { query = "@scope", desc = "Next scope" },
						["]Z"] = { query = "@fold", desc = "Next fold" },
					},
					goto_previous_start = {
						["[f"] = { query = "@function.outer", desc = "Previous function start" },
						["[c"] = { query = "@class.outer", desc = "Previous class start" },
						["[s"] = { query = "@scope", desc = "Previous scope" },
						["[z"] = { query = "@fold", desc = "Previous fold" },
					},
					goto_previous_end = {
						["[F"] = { query = "@function.outer", desc = "Previous function end" },
						["[C"] = { query = "@class.outer", desc = "Previous class end" },
						["[S"] = { query = "@scope", desc = "Previous scope end" },
						["[Z"] = { query = "@fold", desc = "Previous fold end" },
					},
				},
				lsp_interop = {
					enable = true,
					peek_definition_code = {
						["<leader>df"] = { query = "@function.outer", desc = "Peek definition" },
						["<leader>dc"] = { query = "@class.outer", desc = "Peek definition" },
					},
				},
			},
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>st", "<CMD>TodoTrouble<CR>", desc = "Trouble todo list" },
		},
		event = "BufRead",
	},
}
