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
  family = 'IosevkaTerm Nerd Font',
}

-- The size of the font in the tab bar.
-- Default to 10.0 on Windows but 12.0 on other systems
config.font_size = 11.0

config.line_height = 1.2

config.window_padding = { top = 14, bottom = 14, left = 14, right = 14 }

config.colors = colors

config.enable_tab_bar = false

config.window_background_opacity = 1.0

config.enable_wayland = true

return config
