local lualine = require('lualine')
local overseer = require('overseer')

lualine.setup {
    options = {
        theme = 'onedark',
        component_separators = '·',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
            { 'filename' },
        },
        lualine_c = {
            { 'diagnostics', sources = { 'nvim_lsp' } }
        },
        lualine_x = {
            { 'overseer', colored = true,
                symbols = {
                    [overseer.STATUS.FAILURE] = " ",
                    [overseer.STATUS.CANCELED] = " ",
                    [overseer.STATUS.SUCCESS] = " ",
                    [overseer.STATUS.RUNNING] = " ",
                }},
            { 'encoding', colored = true },
            { 'filetype', colored = true },
        },
        lualine_y = {
            { 'branch', icon = '' },
            { 'diff', colored = true, symbols = { added = ' ', modified = '柳', removed = ' ' } },
        },
        lualine_z = {
            { 'location', separator = { right = '' } },
        },
    },
    extensions = { 'nvim-tree' }
}
