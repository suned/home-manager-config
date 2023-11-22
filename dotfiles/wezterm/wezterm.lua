local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.color_scheme = 'Solarized Light (Gogh)'
config.colors = {
    cursor_bg = '#dc322f'
}
config.font = wezterm.font 'JetBrains Mono'
config.enable_tab_bar = false
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_rate = 500
config.line_height = 1.15
config.font_size = 13

--config.leader = { key = 'k', mods = 'SUPER', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 'UpArrow',
        mods = 'SUPER',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'SUPER',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'RightArrow',
        mods = 'SUPER',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'LeftArrow',
        mods = 'SUPER',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'd',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'd',
        mods = 'SUPER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'p',
        mods = 'SUPER',
        action = wezterm.action.ActivateCommandPalette,
    },
    {
        key = 'w',
        mods = 'SUPER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 'k',
        mods = 'SUPER',
        action = act.Multiple {
          act.ClearScrollback 'ScrollbackAndViewport',
          act.SendKey { key = 'L', mods = 'CTRL' },
        },
    }
}


return config
