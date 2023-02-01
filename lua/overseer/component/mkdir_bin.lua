return {
    desc = 'create a bin directory for the compiler to output files to',
    constructor = function (_)
        return {
            on_init = function(_, _)
                io.popen('mkdir -p bin'):close()
            end,
        }
    end
}
