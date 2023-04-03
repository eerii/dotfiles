if vim.g.neovide then
    -- Window
    vim.g.neovide_transparency = 0.9
    vim.g.neovide_background_color = '#121217FF'
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_refresh_rate = 30

    -- Padding
    vim.g.neovide_padding_right = 4
    vim.g.neovide_padding_left = 12

    -- Font
    vim.o.guifont = "SF Mono, Hack Nerd Font:h14"

    -- Panels
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

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
