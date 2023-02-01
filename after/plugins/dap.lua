local dap = require('dap')
local dapui = require('dapui')

-- DAP UI
dapui.setup{}
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
--dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- Python
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- Lua
dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = 'Debug neovim',
    }
}

-- C/C++
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/bin/lldb-vscode',
    name = 'lldb'
}
dap.configurations.cpp = {
    {
        type = 'lldb',
        request = 'launch',
        name = 'Debug C/C++',
        program = './bin/${fileBasenameNoExtension}',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = true,
        args = {},
        env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
        preLaunchTask = 'gcc build',
    }
}
dap.configurations.c = dap.configurations.cpp

-- Java
dap.configurations.java = {
    {
        type = 'java',
        request = 'launch',
        name = 'Debug Java',
        javaExec = '/usr/local/opt/openjdk/bin/java',
    }
}

-- Persistent breakpoints

require('persistent-breakpoints').setup{
    load_breakpoints_event = { "BufReadPost" }
}
