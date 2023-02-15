local overseer = require('overseer')

return {
    name = 'make build',
    builder = function(_)
        return {
            cmd = { 'bear' },
            args = { '--', 'make', '-j', 8 },
            components = { 'on_output_quickfix', 'default' },
            cwd = vim.fn.expand('%:p:h'),
        }
    end,
    desc = 'build a c/c++ project with make',
    tags = { overseer.TAG.BUILD },
    condition = { filetype = { 'c', 'cpp' } },
}
