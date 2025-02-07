-- Pull in the wezterm API
local wezterm = require 'wezterm'
local colors = require 'colors'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- True color with tmux
-- https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6#configuration-files
config.set_environment_variables = {
    TERM = 'xterm-256color'
}

config.font = wezterm.font {
  family = 'Iosevka Nerd Font',
}

-- config.font = wezterm.font_with_fallback { 'Material Symbols Outlined' }

-- The size of the font in the tab bar.
-- Default to 10.0 on Windows but 12.0 on other systems
config.font_size = 11.0

config.line_height = 1.4

config.underline_position = "-3pt"

config.window_padding = { top = 8, bottom = 8, left = 16, right = 16 }

config.colors = colors

config.enable_tab_bar = false

config.window_background_opacity = 1.0

config.default_cursor_style = 'SteadyBar'

config.enable_wayland = true

return config
