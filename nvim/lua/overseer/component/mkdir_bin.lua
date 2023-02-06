return {
    desc = 'create a bin directory for the compiler to output files to',
    constructor = function (_)
        return {
            on_init = function(_, _)
                local dir = vim.fn.expand('%:p:h')
                io.popen('mkdir -p ' .. dir .. '/bin'):close()
            end,
        }
    end
}
