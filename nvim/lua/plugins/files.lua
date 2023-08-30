return {
    -- File manager
    {
        'stevearc/oil.nvim',
        config = true,
        cmd = { 'Oil' },
        keys = { { '<C-f>', '<CMD>Oil --float<CR>', desc = "Open [F]iles directory" } },
    },

    -- Switch between open files
    {
        "theprimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("harpoon").setup()
            require("telescope").load_extension("harpoon")
        end,
        keys = {
            { "<C-m>", function() require("harpoon.mark").add_file() end, desc = "Add harpoon mark" },
            { "<C-n>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon navigation menu" },
            { "<C-e>", function() require("harpoon.cmd-ui").toggle_quick_menu() end, desc = "Toggle harpoon command menu" },
            { "<C-,>", function() require("harpoon.ui").nav_next() end, desc = "Navigate to next harpoon mark" },
            { "<C-.>", function() require("harpoon.ui").nav_prev() end, desc = "Navigate to previous harpoon mark" },
            { "<leader>sM", "<CMD>Telescope harpoon marks<CR>", desc = "Get harpoon marks" },

            { "<C-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Navigate to harpoon tag 1" },
            { "<C-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Navigate to harpoon tag 2" },
            { "<C-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Navigate to harpoon tag 3" },
            { "<C-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Navigate to harpoon tag 4" },
            { "<C-5>", function() require("harpoon.ui").nav_file(5) end, desc = "Navigate to harpoon tag 5" },
            { "<C-6>", function() require("harpoon.ui").nav_file(6) end, desc = "Navigate to harpoon tag 6" },
            { "<C-7>", function() require("harpoon.ui").nav_file(7) end, desc = "Navigate to harpoon tag 7" },
            { "<C-8>", function() require("harpoon.ui").nav_file(8) end, desc = "Navigate to harpoon tag 8" },
            { "<C-9>", function() require("harpoon.ui").nav_file(9) end, desc = "Navigate to harpoon tag 9" },
        }
    }
}
