-- UI
-- Various plugins for the editor UI
-- (Navbar and statusbar are on bars.lua)

return {
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup{
                background_colour = '#040c1a'
            }
            vim.notify = require('notify').notify
        end,
        event = 'VeryLazy'
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            local dashboard = require('alpha.themes.dashboard')

            local logo = [[
            
            oooo                              oooo
            `888                              `888
             888  oooo   .ooooo.   .oooo.      888   .oooo.
             888 .8P'   d88' `88b `P  )88b     888  `P  )88b
             888888.    888   888  .oP\"888    888   .oP\"888
             888 `88b.  888   888 d8(   888    888  d8(   888 
            o888o o888o `Y8bod8P' `Y888\"\"8o o888o `Y888\"\"8o
            ]]
            dashboard.section.header.val = vim.split(logo, "\n            ")
            dashboard.section.buttons.val = {}

            return dashboard
        end,
        config = function(_, dashboard)
            if vim.o.filetype == 'lazy' then
                vim.cmd.close()
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'AlphaReady',
                    callback = function()
                        require('lazy').show()
                    end,
                })
            end

            require('alpha').setup(dashboard.opts)

            vim.api.nvim_create_autocmd('User', {
                pattern = 'LazyVimStarted',
                callback = function()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = '⚡neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
        event = 'VimEnter'
    },
}
