return {
    -- Onedark theme
	{
		'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
		config = function()
			local onedark = require('onedark')
			onedark.setup {
                style = 'deep',
                transparent = true
            }
			onedark.load()
		end,
        enabled = false
	},

    -- Tokyonight theme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup{
                style = 'storm',
                transparent = true
            }
            vim.cmd.colorscheme('tokyonight')
        end,
        enabled = false
    },

    -- Kanawara theme
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority  = 1000,
        config = function()
            require('kanagawa').setup{
                transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = { bg_gutter = "none" }
                        }
                    }
                }
            }
            vim.cmd.colorscheme('kanagawa')
        end
    },
}
