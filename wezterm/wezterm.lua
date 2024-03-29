local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.color_scheme = "Ayu Dark (Gogh)"
config.window_background_opacity = 0.9

config.hide_tab_bar_if_only_one_tab = true

local act = wezterm.action
config.keys = {
	{
		key = "c",
		mods = "CTRL",
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL",
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "SUPER",
		action = act.SendKey({ key = "c", mods = "CTRL" }),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
}

smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "CTRL|SHIFT",
	},
})

return config
