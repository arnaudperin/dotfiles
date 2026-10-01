-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- initial geometry for new windows
config.initial_cols = 120
config.initial_rows = 28

-- font size and color scheme.
config.font_size = 10
config.color_scheme = 'rose-pine-moon'

-- window parameter
config.window_decorations = "RESIZE"

config.enable_tab_bar = false

-- Finally, return the configuration to wezterm:
return config

