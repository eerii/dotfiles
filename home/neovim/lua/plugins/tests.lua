return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "rcasia/neotest-java",
            "antoinemadec/FixCursorHold.nvim",
        },
        config = function()
            require "configs.tests"
        end,
        keys = {
            {
                "<leader>tt",
                function()
                    require("neotest").run.run(vim.fn.expand "%")
                end,
                desc = "Run File",
            },
            {
                "<leader>ta",
                function()
                    require("neotest").run.run(vim.uv.cwd())
                end,
                desc = "Run All Test Files",
            },
            {
                "<leader>tn",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run Nearest",
            },
            {
                "<leader>to",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle Summary",
            },
            {
                "<leader>tO",
                function()
                    require("neotest").output.open { enter = true, auto_close = true }
                end,
                desc = "Show Output",
            },
            {
                "<leader>tP",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Toggle Output Panel",
            },
            {
                "<leader>tq",
                function()
                    require("neotest").run.stop()
                end,
                desc = "Stop",
            },
        },
    },
}
