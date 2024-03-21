return {
    -- cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "exafunction/codeium.vim" },
        config = function()
            require "configs.cmp"
        end,
    },

    -- codeium (completions disabled)
    {
        "exafunction/codeium.vim",
        config = function()
            vim.g.codeium_disable_bindings = true
            vim.g.codeium_manual = true
            vim.g.codeium_workspace_root_hints = { ".git", "cargo.toml", "Makefile", "package.json", "init.lua" }
        end,
        keys = {
            { "<leader>cd", "<CMD>call codeium#Chat()<CR>", desc = "Chat Codeium" },
            { "<C-q>",      mode = { "i", "s" } },
        }
    },

    -- copilot chat
    {
        "copilotc-nvim/copilotchat.nvim",
        branch = "canary",
        dependencies = {
            {
                "zbirenbaum/copilot.lua",
                opts = {
                    panel = {
                        enabled = false,
                    },
                    suggestion = {
                        enabled = false,
                    },
                },
            },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            debug = true,
            show_help = false,
            window = {
                layout = "float",
                relative = "cursor",
                width = 1,
                height = 0.4,
                row = 1,
            },
            mappings = {
                reset = "<C-r>",
                accept_diff = "<C-y>",
                show_diff = "gd",
                show_system_prompt = "gp",
                show_user_selection = "gs",
            },
        },
        keys = {
            { "<leader>ca", ":CopilotChat ",                     mode = { "n", "v" },         desc = "Chat Copilot ask" },
            { "<leader>cw", ":CopilotChat @buffers ",            mode = { "n", "v" },         desc = "Chat Copilot ask workspace" },
            { "<leader>ce", "<CMD>CopilotChatExplain<CR>",       mode = { "n", "v" },         desc = "Chat Copilot explain" },
            { "<leader>cf", "<CMD>CopilotChatFix<CR>",           mode = { "n", "v" },         desc = "Chat Copilot fix" },
            { "<leader>cF", "<CMD>CopilotChatFixDiagnostic<CR>", mode = { "n", "v" },         desc = "Chat Copilot fix diagnostic" },
            { "<leader>co", "<CMD>CopilotChatOptimize<CR>",      mode = { "n", "v" },         desc = "Chat Copilot optimize" },
            { "<leader>cT", "<CMD>CopilotChatTests<CR>",         mode = { "n", "v" },         desc = "Chat Copilot tests" },
            { "<leader>cD", "<CMD>CopilotChatDocs<CR>",          mode = { "n", "v" },         desc = "Chat Copilot docs" },
            { "<leader>cC", "<CMD>CopilotChatCommit<CR>",        mode = { "n", "v" },         desc = "Chat Copilot commit" },
            { "<leader>ct", "<CMD>CopilotChatToggle<CR>",        desc = "Chat Copilot toggle" },
            {
                "<leader>cb",
                function()
                    local input = vim.fn.input("Buffer Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "Chat Copilot ask buffer"
            },
        }
    },

}
