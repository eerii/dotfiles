-- DAP UI

local dapui_config = {
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

-- Debug adapters

local lldb_adapter = { -- Can be finicky with breakpoints
    type = 'executable',
    command = '/usr/local/bin/lldb-vscode',
    name = 'lldb'
}

local cppdbg_adapter = { -- Can use GDB, no console
    type = 'executable',
    command = vim.fn.expand('$HOME') .. '/.local/share/nvim/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    name = 'cppdbg',
    id = 'cppdbg'
}

local codelldb_host = '127.0.0.1'
local codelldb_port = 16800
local codelldb_adapter = {
    type = 'server',
    port = codelldb_port,
    executable = {
        command = vim.fn.expand('$HOME') .. '/.local/share/nvim/codelldb/extension/adapter/codelldb',
        args = {"--port", codelldb_port},
    }
}

-- Debug configurations

local python_config = {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    console = 'integratedTerminal',
}

local c_cpp_config = {
    type = 'codelldb',
    request = 'launch',
    name = 'Debug C/C++',
    program = './${relativeFileDirname}/bin/${fileBasenameNoExtension}',
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    preLaunchTask = 'gcc build',
    --env = function()
    --    local variables = {}
    --    for k, v in pairs(vim.fn.environ()) do
    --        table.insert(variables, string.format('%s=%s', k, v))
    --    end
    --    return variables
    --end, 
    --MIMode = 'lldb', (for cppdbg)
    --runInTerminal = true, (for lldb-vscode)
    terminal = 'integrated',
}

local make_config = {
    type = 'codelldb',
    request = 'launch',
    name = 'Debug C/C++ (make)',
    program = './${relativeFileDirname}/bin/main',
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    preLaunchTask = 'make build',
    --env = function()
    --    local variables = {}
    --    for k, v in pairs(vim.fn.environ()) do
    --        table.insert(variables, string.format('%s=%s', k, v))
    --    end
    --    return variables
    --end, 
    --MIMode = 'lldb', (for cppdbg)
    --runInTerminal = true, (for lldb-vscode)
    terminal = 'integrated',
}

local java_config = {
    type = 'java',
    request = 'launch',
    name = 'Debug Java',
    preLaunchTask = 'gradle build'
}

-- DAP Setup

local dap_setup = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup(dapui_config)
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end

    dap.configurations.python = python_config
    dap.configurations.c = { c_cpp_config, make_config }
    dap.configurations.cpp = { c_cpp_config, make_config }
    dap.configurations.java = java_config

    dap.adapters.lldb = lldb_adapter
    dap.adapters.cppdbg = cppdbg_adapter
    dap.adapters.codelldb = codelldb_adapter

    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

    vim.fn.sign_define('DapBreakpoint', { text = '●' })
    vim.fn.sign_define('DapLogPoint', { text = '⚑' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '✖' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '○' })

    require('dap').set_log_level('DEBUG')
end

return {
    setup = dap_setup,
    config = {
        python = python_config,
        ccpp = c_cpp_config,
        make = make_config,
        java = java_config,
    },
}
