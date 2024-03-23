local opts = function()
    return {
        handlers = {
            ["$/progress"] = function() end,
        },
        settings = {
            java = {},
        },
        on_attach = require "configs.onattach",

        -- how to find the root dir for a given filename
        root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

        -- how to find the project name for a given root dir
        project_name = function(root_dir)
            return root_dir and vim.fs.basename(root_dir)
        end,

        -- where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
            return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
            return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/workspace"
        end,

        -- how to run jdtls
        cmd = { vim.fn.exepath "jdtls" },
        full_cmd = function(opts)
            local fname = vim.api.nvim_buf_get_name(0)
            local root_dir = opts.root_dir(fname)
            local project_name = opts.project_name(root_dir)
            local cmd = vim.deepcopy(opts.cmd)
            if project_name then
                vim.list_extend(cmd, {
                    "-configuration",
                    opts.jdtls_config_dir(project_name),
                    "-data",
                    opts.jdtls_workspace_dir(project_name),
                })
            end
            return cmd
        end,
    }
end

local attach_jdtls = function()
    local fname = vim.api.nvim_buf_get_name(0)

    local config = opts()
    config.cmd = config.full_cmd(config)

    config.root_dir = config.root_dir(fname)
    vim.notify("JDTLS root dir: " .. config.root_dir)

    local pn = config.project_name(config.root_dir)
    vim.notify("JDTLS project name: " .. pn)

    config.capabilities = require("cmp_nvim_lsp").default_capabilities()
    config.on_attach = require "configs.onattach"

    require("jdtls").start_or_attach(config)
end

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "java",
    callback = attach_jdtls,
})
