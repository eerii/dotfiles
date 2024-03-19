return {
    -- improved ui elements
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = { enabled = false },
                signature = { enabled = false },
            },
        },
        keys = {
            { "<leader>sn", "<CMD>Noice telescope<CR>", desc = "Search notifications" },
        },
        event = "VeryLazy",
    }
}
