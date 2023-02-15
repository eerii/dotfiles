local overseer = require('overseer')

return {
    name = 'ant build',
    builder = function(_)
        return {
            cmd = { 'ant' },
            args = { 'compile' },
            components = { 'on_output_quickfix', 'default' },
            cwd = vim.fn.getcwd(),
        }
    end,
    desc = 'build an ant project',
    tags = { overseer.TAG.BUILD },
    condition = { filetype = { 'java' } },
}
