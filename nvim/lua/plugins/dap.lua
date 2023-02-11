-- DAP
-- https://github.com/mfussenegger/nvim-dap
-- Debug adapter protocol, tools for debugging on neovim

-- Debug adapters

local lldb_adapter = {
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
    terminal = 'integrated',
    --runInTerminal = true, (for lldb-vscode)
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
    terminal = 'integrated',
    --runInTerminal = true, (for lldb-vscode)
}

local java_config = {
    type = 'java',
    request = 'launch',
    name = 'Debug Java',
    preLaunchTask = 'gradle build'
}

-- Helper functions
local file_exists = function(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local filetypes = { 'c', 'cpp', 'java', 'python' }

return {
    {
        'stevearc/overseer.nvim', -- Task runner
        opts = {
            dap = true,
            templates = {
                'builtin',
                'ccppbuild',
                'javabuild'
            },
        },
        ft = filetypes,
    },
    {
        'weissle/persistent-breakpoints.nvim', -- Save breakpoints automatically
        opts = {
            load_breakpoints_event = { "BufReadPost" }
        },
        keys = function()
            local has_pbr, pbr = pcall(require, 'persistent-breakpoints.api')
            if (not has_pbr) then return {} end
            return {
                { '<C-b>', pbr.toggle_breakpoint, desc = 'DAP Toggle [B]reakpoint' },
                { '<leader>cb', pbr.set_conditional_breakpoint, desc = 'DAP [C]onditional [B]reakpoint' },
                { '<leader>dbr', pbr.clear_all_breakpoints, desc = 'DAP [D]elete all [Br]eakpoints' }
            }
        end,
        ft = filetypes,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui' , -- UI for debugging
                opts = {
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
            },
            'thehamsta/nvim-dap-virtual-text', -- Virtual text for DAPs
            'mfussenegger/nvim-dap-python', -- DAP for python
            {
                'nvim-telescope/telescope-dap.nvim', -- Telescope functions for DAPs
                config = function()
                    require('telescope').load_extension('dap')
                end
            }
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end

            dap.configurations = {
                python = { python_config },
                c = { c_cpp_config, make_config },
                cpp = { c_cpp_config, make_config },
                java = { java_config }
            }

            dap.adapters = {
                lldb = lldb_adapter,
                cppdbg = cppdbg_adapter,
                codelldb = codelldb_adapter,
            }

            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

            vim.fn.sign_define('DapBreakpoint', { text = '●' })
            vim.fn.sign_define('DapLogPoint', { text = '⚑' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '✖' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '○' })
        end,
        keys = function()
            local has_dap, dap = pcall(require, 'dap')
            local has_dapui, dapui = pcall(require, 'dapui')
            if (not has_dap or not has_dapui) then return {} end

            return {
                { '<F10>', dap.continue, desc = 'DAP continue' },
                { '<F9>', dap.step_over, desc = 'DAP step over' },
                { '<F8>', dap.step_into, desc = 'DAP step in' },
                { '<F7>', dap.step_out, desc = 'DAP step out' },
                { '<C-q>', function()
                    if dap.session() then dap.terminate() end
                    dapui.toggle()
                end, desc = 'DAP [Q]uit debug (and toggle UI)' },
                { '<C-e>', function()
                    if vim.bo.filetype == 'c' or vim.bo.filetype == 'cpp' then
                        -- If there is a makefile
                        if file_exists(vim.fn.expand('%:p:h') .. '/makefile') then
                            dap.run(make_config)
                        else
                            dap.run(c_cpp_config)
                        end
                    elseif vim.bo.filetype == 'python' then
                        dap.run(python_config)
                    elseif vim.bo.filetype == 'java' then
                        dap.run(java_config)
                    end
                end, desc = 'Start debugging' }
            }
        end,
        ft = filetypes,
    },
}
