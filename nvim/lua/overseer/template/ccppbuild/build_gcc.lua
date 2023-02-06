local overseer = require('overseer')

return {
    name = 'gcc build',
    builder = function(_)
        local file = vim.fn.expand('%:p')
        local filename = vim.fn.expand('%:t:r')
        local dir = vim.fn.expand('%:p:h')
        return {
            cmd = { '/usr/local/bin/gcc-12' },
            args = { file, '-o', dir .. '/bin/' .. filename, '-g', '-Wall' },
            components = { 'mkdir_bin', 'on_output_quickfix', 'default' },
            cwd = dir,
        }
    end,
    desc = 'build a single c file with gcc and output in bin/file',
    tags = { overseer.TAG.BUILD },
    condition = { filetype = { 'c' } },
}
