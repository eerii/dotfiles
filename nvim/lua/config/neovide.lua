if vim.g.neovide then
    -- Window
    local alpha = function()
        return string.format('%x', math.floor(255 * (vim.g.transparency or 0.8)))
    end
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 0.98
    vim.g.neovide_background_color = '#0f1117' .. alpha()
    vim.g.neovide_remember_window_size = true

    -- Font
    vim.o.guifont = "SFMono Nerd Font:h14"

    -- Panels
    --vim.g.neovide_floating_blur_amount_x = 2.0
    --vim.g.neovide_floating_blur_amount_y = 2.0

    -- Mouse and cursor
    vim.g.neovide_hide_mouse_when_typing = false
    vim.g.neovide_cursor_animation_length = 0.07
    vim.g.neovide_cursor_trail_size = 0.4
    vim.g.neovide_cursor_vfx_mode = "pixiedust"

    -- Remaps for system keys
    vim.g.neovide_input_use_logo = true
    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set({'n', 'v'}, '<D-v>', '"+P') -- Paste normal/visual mode
    vim.keymap.set({'c', 'i'}, '<D-v>', '<C-R>+') -- Paste command/insert mode
end
