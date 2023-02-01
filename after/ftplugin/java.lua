local jdtls = require('jdtls')

-- Workspace folder
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
project_name = project_name:lower():gsub('%W', '-')
local workspace = vim.fn.expand('$HOME/.cache/jdtls/workspace/') .. project_name

-- Java debug adapter
local jda_path = vim.fn.glob(vim.fn.expand('$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'))

local config = {
    cmd = {
        '/usr/local/bin/jdtls',
        '-data', workspace,
    },
    root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    settings = {
        java = {

        }
    },
    init_options = {
        bundles = {
            jda_path
        }
    },
    on_attach = function (_, _)
        jdtls.setup_dap({ hotcodereplace = 'auto' })
    end
}
jdtls.start_or_attach(config)
