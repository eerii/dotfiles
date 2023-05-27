local make = nil

return {
    -- Toggle terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<C-t>]],
                start_in_insert = true,
                insert_mappings = true,
                direction = "vertical",
                size = 50,
            }

            -- Custom terminals
            local term = require("toggleterm.terminal").Terminal
            make = term:new({ cmd = "bear -- make -j 8 && ./bin/main", close_on_exit = false, hidden = true })
        end,
        keys = {
            "<C-t>",
            { "<leader>mk", function() if make ~= nil then make:toggle() end end, desc = "Make and run" }
        }
    }
}
