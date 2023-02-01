local overseer = require('overseer')

return {
    name = 'gcc build',
    builder = function(_)
        local file = vim.fn.expand('%:p')
        local filename = vim.fn.expand('%:t:r')
        return {
            cmd = { '/usr/local/bin/gcc-12' },
            args = { file, '-o', './bin/' .. filename, '-g', '-Wall' },
            components = { 'mkdir_bin', 'on_output_quickfix', 'default' },
            cwd = vim.fn.getcwd(),
        }
    end,
    desc = 'build a single c file with gcc and output in bin/file',
    tags = { overseer.TAG.BUILD },
    condition = { filetype = { 'c' } },
}
