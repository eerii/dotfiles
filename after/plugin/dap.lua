local dap = require('dap')
local dapui = require('dapui')
local overseer = require('overseer')

-- DAP UI
dapui.setup{
    layouts = {
        {
            elements = {
                { id = 'scopes', size = 0.65 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.1 },
            },
            position = 'left',
            size = 32,
        },
        {
            elements = {
                { id = 'repl', size = 0.5 },
                { id = 'console', size = 0.5 },
            },
            position = 'bottom',
            size = 8,
        }
    }
}
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
--dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
--dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- Virtual text
require('nvim-dap-virtual-text').setup()

-- Python
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
local python_config = {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    console = 'integratedTerminal',
}

-- Lua
dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end
local lua_config = {
    type = 'nlua',
    request = 'attach',
    name = 'Debug neovim',
}
dap.configurations.lua = {
    lua_config
}

-- C/C++
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/bin/lldb-vscode',
    name = 'lldb'
}

-- C/C++ gcc
local c_cpp_config = {
    type = 'lldb',
    request = 'launch',
    name = 'Debug C/C++',
    program = './${relativeFileDirname}/bin/${fileBasenameNoExtension}',
    cwd = vim.fn.getcwd(),
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

-- C/C++ make
local make_config = c_cpp_config
make_config.name = 'Debug C/C++ (make)'
make_config.program = './${relativeFileDirname}/bin/main'
make_config.preLaunchTask = 'make build'

dap.configurations.cpp = {
    c_cpp_config,
    make_config
}
dap.configurations.c = dap.configurations.cpp

-- Java
local java_config = {
    type = 'java',
    request = 'launch',
    name = 'Debug Java',
    preLaunchTask = 'gradle build'
}
dap.configurations.java = {
    java_config
}

-- Start running keymap (using configurations)
vim.keymap.set('n', '<C-e>', function ()
    if vim.bo.filetype == 'c' then
        -- If there is a makefile
        if vim.fn.filereadable('Makefile') then
            dap.run(make_config)
        else
            dap.run(c_cpp_config)
        end
    elseif vim.bo.filetype == 'cpp' then
        dap.run(c_cpp_config)
    elseif vim.bo.filetype == 'lua' then
        require('osv').launch({port = 8086})
    elseif vim.bo.filetype == 'python' then
        dap.run(python_config)
    elseif vim.bo.filetype == 'java' then
        dap.run(java_config)
    end
end, { desc = 'Start debugging' })

-- Persistent breakpoints

require('persistent-breakpoints').setup{
    load_breakpoints_event = { "BufReadPost" }
}
