if vim.g.neovide then
	-- Padding
	vim.g.neovide_padding_top = 24
	vim.g.neovide_padding_left = 16

	-- Font
	vim.o.guifont = "JetBrains Mono:h14"

	-- Panels
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	-- Mouse and cursor
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_cursor_animation_length = 0.07
	vim.g.neovide_cursor_trail_size = 0.4

	-- Remaps for system keys
	vim.g.neovide_input_use_logo = true
end
