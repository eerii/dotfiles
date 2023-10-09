return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "folke/neodev.nvim", -- Neovim development
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(e)
                    local map = vim.keymap.set
                    map("n", "gh", vim.lsp.buf.hover, { buffer = e.buf, desc = "[L]SP [H]over info" })
                    map("n", "ga", vim.lsp.buf.code_action, { buffer = e.buf, desc = "[L]SP [C]ode [A]ctions" })
                    map("n", "gI", require("telescope.builtin").lsp_implementations, { buffer = e.buf, desc = "[L]SP [I]mplementation" })
                    map("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = e.buf, desc = "[L]SP [D]efinition" })
                    map("n", "gt", require("telescope.builtin").lsp_type_definitions, { buffer = e.buf, desc = "[L]SP [T]ype definition" })
                    map("n", "gr", require("telescope.builtin").lsp_references, { buffer = e.buf, desc = "[L]SP [R]eferences" })
                    map("n", "gi", require("telescope.builtin").lsp_incoming_calls, { buffer = e.buf, desc = "[L]SP [I]ncoming calls" })
                    map("n", "go", require("telescope.builtin").lsp_outgoing_calls, { buffer = e.buf, desc = "[L]SP [O]utgoing calls" })
                    map("n", "gD", vim.lsp.buf.declaration, { buffer = e.buf, desc = "[L]SP [D]eclaration" })
                    map("n", "<leader>lr", vim.lsp.buf.rename, { buffer = e.buf, desc = "[L]SP [R]ename" })
                    map("n", "<leader>lf", function () vim.lsp.buf.format { async = true } end, { buffer = e.buf, desc = "[L]SP [F]ormat" })
                end
            })

            -- Specific filetype plugins
            require("neodev").setup()

            -- General LSP
            local lsp = require("lspconfig")

            -- Mason config
            require("mason").setup()
            require("mason-lspconfig").setup{
                ensure_installed = {
                    "lua_ls",
                    "jdtls"
                },
                automatic_installation = {
                    exclude = { "rust_analyzer" }
                },
                handlers = {
                    function (server_name)
                        lsp[server_name].setup {}
                    end,
                    ["jdtls"] = function() end
                }
            }

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                severity_sort = true,
            })
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
        event = "BufEnter",
        keys = {
            { "[d", vim.diagnostic.goto_next, desc = "LSP next [D]iagnostic" },
            { "]d", vim.diagnostic.goto_prev, desc = "LSP previous [D]iagnostic" },
            { "gd", vim.diagnostic.open_float, desc = "LSP show line [D]iagnostics" },
            { "<leader>lsp", ":LspInfo<CR>", desc = "[LSP] Info" },
        }
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        cmd = { "Mason", "MasonUpdate" },
        keys = { { "<leader>M", ":Mason<CR>", desc = "[M]ason Language Servers" } },
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local configure = function()
                local path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

                return {
                    cmd = { path },
                    root_dir = vim.fs.dirname(vim.fs.find({"gradlew", ".git", "mvnw", "settings.gradle.kts"}, { upward = true })[1]),
                    handlers = {
                        ["$/progress"] = function() end,
                        --["language/status"] = function() end,
                    },
                    settings = {
                        java = {},
                    },
                    on_attach = function(_, buf)
                        vim.keymap.set('n', "<leader>jo", require("jdtls").organize_imports, { desc = '[J]ava [O]rganize imports', buffer = buf })
                        vim.keymap.set('n', "<leader>jc", require("jdtls").compile, { desc = '[J]ava [C]ompile', buffer = buf })
                        vim.keymap.set('n', '<leader>jv', require("jdtls").extract_variable_all, { desc = '[J]ava extract [V]ariable', buffer = buf })
                        vim.keymap.set('n', '<leader>js', require("jdtls").super_implementation, { desc = '[J]ava jump to [S]uper', buffer = buf })
                    end
                }
            end

            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "java",
                callback = function()
                    require("jdtls").start_or_attach(configure())
                end,
            })
        end,
        ft = "java",
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { command = "clippy" }
                    }
                },
                server = {
                    on_attach = function(_, _) end,
                },
            }
        end,
        ft = "rust",
    },
    {
        "ms-jpq/coq_nvim",
        enabled = false,
        branch = "coq",
        dependencies = {
            {
                "ms-jpq/coq.artifacts",
                branch = "artifacts"
            },
            {
                "ms-jpq/coq.thirdparty",
                branch = "3p"
            },
            {
                "exafunction/codeium.vim",
                config = function()
                    vim.g.codeium_manual = true
                    vim.g.codeium_disable_bindings = 1
                    vim.g.codeium_is_active = false
                end,
            },
        },
        build = ":COQdeps",
        config = function()
            vim.g.coq_settings = {
                keymap = {
                    recommended = false,
                    pre_select = true,
                },
                -- clients = {},
                display = {
                    pum = {
                        fast_close = false,
                        y_max_len = 5,
                    },
                    ghost_text = {
                        context =  { "   · ", " ·   " },
                    },
                    icons = {
                        mode = "short",
                    },
                    preview = {
                        enabled = false,
                    },
                },
                completion = {
                   skip_after = {"{", "}", "[", "]", ","},
                },
                auto_start = "shut-up",
            }

            vim.cmd [[COQnow --shut-up]]

            vim.api.nvim_exec([[
                function! TextBefore()
                    let before_cursor = getline('.')[:col('.')-1]
                    let before_char = strcharpart(before_cursor, strchars(before_cursor)-1)
                    return col('.') > 1 && before_char !~ '\s'
                endfunction
            ]], false)

            require("coq_3p") {
                {
                    src = "repl",
                    sh = "bash",
                    shell = { p = "python3", f = "fish" },
                    max_lines = 100,
                    deadline = 500,
                    unsafe = { "rm", "sudo", "mv", "poweroff" },
                },
                {
                    src = "bc",
                    short_name = "MATH",
                    precision = 6,
                },
                {
                    src = "figlet",
                    short_name = "TITLE",
                    trigger = "!t",
                    fonts = { "/usr/share/figlet/fonts/small.flf" },
                },
            }
        end,
        keys = function()
            local if_coq = function(open, close)
                local coq = vim.fn.pumvisible() == 1
                local cmd_str = coq and open or close
                local cmd = vim.api.nvim_replace_termcodes(cmd_str, true, false, true)
                vim.api.nvim_feedkeys(cmd, "n", false)
            end

            local close_coq = function(key)
                if_coq("<C-e>" .. key, key)
            end

            local complete = function()
                if vim.g.codeium_is_active then
                    vim.g.codeium_is_active = false
                    return vim.fn["codeium#Accept"]()
                end
                local is_selected = vim.fn.complete_info() ~= -1
                local cmd = is_selected and "<C-y>" or "<C-e><Tab>"
                if_coq(cmd, "<Tab>")
            end

            local codeium_next = function(arg, fallback)
                if vim.g.codeium_is_active then
                    vim.fn["codeium#CycleCompletions"](arg)
                    print(vim.fn["codeium#GetStatusString"]())
                    return
                end
                local cmd = vim.api.nvim_replace_termcodes(fallback, true, false, true)
                vim.api.nvim_feedkeys(cmd, "n", false)
            end

            local toggle_codeium = function()
                if vim.g.codeium_is_active then
                    vim.fn["codeium#Clear"]()
                else
                    close_coq("<CMD>call codeium#Complete()<CR>")
                end
                vim.g.codeium_is_active = not vim.g.codeium_is_active
            end

            return {
                { "<Esc>", function() if_coq("<C-e><Esc>", "<Esc>") end, mode = "i" },
                { "<C-c>", function() close_coq("<C-c>") end, mode = "i" },
                { "<C-u>", function() close_coq("<C-u>") end, mode = "i" },
                { "<BS>", function() close_coq("<BS>") end, mode = "i" },
                { "<CR>", function() close_coq("<CR>") end, mode = "i" },
                { "<Tab>", complete, mode = "i", expr = true, silent = true },
                { "<C-w>", 'pumvisible() ? (TextBefore() ? "\\<C-e><C-w>" : "\\<C-e>") : "\\<C-w>"', mode = "i", expr = true },
                { "<C-q>", toggle_codeium, mode = "i" },
                { "<C-n>", function() codeium_next(1, "<C-n>") end, mode = "i" },
                { "<C-p>", function() codeium_next(-1, "<C-p>") end, mode = "i" },
            }
        end,
    },

    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "l3mon4d3/luasnip",
    --         "saadparwaiz1/cmp_luasnip",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         local luasnip = require("luasnip")
    --
    --         cmp.setup {
    --             sources = {
    --                 { name = "nvim_lsp", max_item_count = 5 },
    --                 { name = "luasnip", max_item_count = 5 },
    --             },
    --             mapping = cmp.mapping.preset.insert {
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                     -- if copilot.is_visible() then
    --                     --     copilot.accept()
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     elseif luasnip.expand_or_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --
    --                 ["<S-Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     elseif luasnip.jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --
    --                 ["<CR>"] = cmp.mapping({
    --                     i = function(fallback)
    --                         if cmp.visible() and cmp.get_active_entry() then
    --                             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    --                         else
    --                             fallback()
    --                         end
    --                     end,
    --                     s = cmp.mapping.confirm({ select = true }),
    --                     c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    --                 }),
    --
    --                 ["<C-W>"] = cmp.mapping(
    --                     function(_)
    --                         if cmp.visible() then
    --                             cmp.abort()
    --                         else
    --                             cmp.complete()
    --                         end
    --                     end
    --                 ),
    --             },
    --             snippet = {
    --                 expand = function(args)
    --                     require("luasnip").lsp_expand(args.body)
    --                 end
    --             },
    --             performance = {
    --                 debounce = 150,
    --             },
    --             experimental = {
    --                 ghost_text = true,
    --             }
    --         }
    --     end,
    -- }
}

--[[

return {
    -- LSP Support
    {
        'vonheikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            {
                'williamboman/mason.nvim',
                build = ':MasonUpdate',
                cmd = { 'Mason', 'MasonUpdate' },
                keys = { { '<leader>M', ':Mason<CR>', desc = '[M]ason Language Servers' } },
            },
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind.nvim',
            'l3mon4d3/luasnip',
            'saadparwaiz1/cmp_luasnip',
            'felipelema/cmp-async-path',
            'paopaol/cmp-doxygen',
            'simrat39/rust-tools.nvim',
            'smiteshp/nvim-navic',
            'p00f/clangd_extensions.nvim',
            {
                'quarto-dev/quarto-nvim',
                dependencies = { {
                    'jmbuhr/otter.nvim',
                    dev = false,
                    config = function()
                        require 'otter.config'.setup()
                    end
                } },
                config = true
            },
            {
                'zbirenbaum/copilot.lua',
                opts = {
                    suggestion = {
                        enabled = true,
                        auto_trigger = false,
                        keymap = {
                            accept = false,
                        }
                    },
                    panel = {
                        enabled = true,
                        auto_refresh = true,
                    },
                    filetypes = {
                        markdown = true,
                    }
                },
                keys = {
                    {
                        '<C-w>',
                        function()
                            require('cmp').close()
                            require('copilot.suggestion').next()
                        end,
                        desc = 'Trigger Copilot',
                        mode = 'i'
                    },
                    {
                        '<leader>cp',
                        function()
                            require('copilot.panel').open()
                        end,
                        desc = 'Copilot panel',
                    },
                    {
                        '<leader>cs',
                        ':Copilot<CR>',
                        desc = 'Copilot status',
                    },
                    {
                        '<leader>ct',
                        ':Copilot toggle<CR>',
                        desc = 'Copilot toggle',
                    }
                }
            },
        },
        config = function()
            local rt = require('rust-tools')
            local cargo_env = { CARGO_TARGET_DIR = './target.nosync' }
            rt.setup({
                server = {
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = { extraEnv = cargo_env },
                            server = { extraEnv = cargo_env },
                            runnableEnv = cargo_env,
                            checkOnSave = { command = 'clippy' }
                        }
                    },
                    on_attach = function(_, bufnr)
                        vim.keymap.set('n', '<leader>ca', rt.hover_actions.hover_actions, { buffer = bufnr })
                    end
                },
            })

            local cld = require('clangd_extensions')
            cld.setup({
                server = {
                    capabilities = {
                        offset_encoding = "utf-8"
                    }
                }
            })

            local cmp = require('cmp')
            local copilot = require('copilot.suggestion')
            local luasnip = require('luasnip')

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lua',                max_item_count = 3 },
                    { name = 'nvim_lsp',                max_item_count = 5 },
                    { name = 'nvim_lsp_signature_help', max_item_count = 3 },
                    { name = 'otter',                   max_item_count = 3 },
                    { name = 'luasnip',                 max_item_count = 3 },
                    { name = 'async_path',              max_item_count = 7 },
                    { name = 'doxygen',                 max_item_count = 7 },
                }),
                formatting = {
                    format = require('lspkind').cmp_format {
                        maxwidth = 50,
                        ellipsis_char = '...',
                        fields = { 'abbr', 'kind' },
                        menu = {},
                    },
                }
            })
        end,
        event = { 'BufEnter' },
            }
}
]]--
