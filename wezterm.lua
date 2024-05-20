-- Use wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- Start full-screen
wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

-- Config
local config = wezterm.config_builder()

config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.send_composed_key_when_left_alt_is_pressed = true

-- Color
config.color_scheme = 'iceberg-dark'
config.colors = {
  foreground = '#E0E0E0',
  background = '#000000',
}

-- Font

config.font = wezterm.font('BerkeleyMono Nerd Font')
config.font_size = 14.5
config.line_height = 1.1
config.bold_brightens_ansi_colors = false

-- Harfbuzz (disable ligatures)
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- DHH
-- config.color_scheme = 'tokyonight_night'
-- config.font = wezterm.font('Cascadia Mono')
-- config.font_size = 15.0

-- Return config
return config
