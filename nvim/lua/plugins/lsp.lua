return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "hrsh7th/nvim-cmp",
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

            -- Per LSP settings
            lsp.lua_ls.setup {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "l3mon4d3/luasnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup {
                sources = {
                    { name = "nvim_lsp", max_item_count = 5 },
                    { name = "luasnip", max_item_count = 5 },
                },
                completion = {
                    -- autocomplete = false
                },
                mapping = cmp.mapping.preset.insert {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),

                    ["<C-W>"] = cmp.mapping(
                        function(_)
                            if cmp.visible() then
                                cmp.abort()
                            else
                                cmp.complete()
                            end
                        end
                    ),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                performance = {
                    debounce = 150,
                },
                experimental = {
                    ghost_text = true,
                }
            }
        end,
    }
}
