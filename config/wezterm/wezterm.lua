local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Tokyo Night Moon'
config.font = wezterm.font 'RecMonoCasual Nerd Font'
config.window_background_opacity = 0.8

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.window_frame = {
    active_titlebar_bg = "rgba(30, 30, 30, 0.8)",
    inactive_titlebar_bg = "rgba(30, 30, 30, 0.8)",
}

return config
