local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Lilex Nerd Font'
config.default_prog = { 'powershell' }
config.keys = {
    {
        key = 'Backspace',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentTab{confirm=true},
    },

    {
        key = '°',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = '§',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = 'ℓ',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = '»',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = '«',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTab(4),
    },
}

return config
