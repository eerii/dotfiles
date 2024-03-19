---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "ayu_dark",
    transparency = false,

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },

    statusline = {
        theme = "minimal",
        separator_style = "block",
    },

    tabufline = {
        enabled = false,
    },

    nvdash = {
        load_on_startup = false,
    },

    cmp = {
        lspkind_text = false,
        style = "flat_dark",
    },
}

return M
