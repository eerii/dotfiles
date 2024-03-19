---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "ayu_dark",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },

    statusline = {
        separator_style = "block",
    },

    tabufline = {
        enabled = false,
    },

    nvdash = {
        load_on_startup = true,
    }
}

return M
