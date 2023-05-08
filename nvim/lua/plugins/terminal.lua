local lazygit = nil
local make = nil

return {
    -- Toggle terminal
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<C-t>]],
                start_in_insert = true,
                insert_mappings = true,
                direction = 'vertical',
                size = 50,
                on_open = function() -- Fix weird neovide bug
                    vim.o.cmdheight = 1
                end,
                on_close = function()
                    vim.o.cmdheight = 0
                end,
            }

            -- Custom terminals
            local term = require('toggleterm.terminal').Terminal
            lazygit = term:new({ cmd = 'lazygit', direction = 'float', hidden = true })
            make = term:new({ cmd = 'bear -- make -j 8 && ./bin/main', close_on_exit = false, hidden = true })
        end,
        event = 'VeryLazy',
        keys = {
            { '<leader>gl', function()
                if lazygit ~= nil then
                    lazygit:toggle()
                end
            end, desc = '[G]it open [L]azy view' },
            { '<leader>mk', function()
                if make ~= nil then
                    make:toggle()
                end
            end, desc = '[M]a[k]e and run' }
        }
    }
}
