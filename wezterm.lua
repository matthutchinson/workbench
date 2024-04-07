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

-- Color
config.color_scheme = 'iceberg-dark'
config.bold_brightens_ansi_colors = false
config.colors = {
  foreground = '#C0C5CE',
  background = '#000000',
}

-- Font
config.font = wezterm.font('BerkeleyMono Nerd Font', { weight = 'Regular' })
config.font_size = 14
config.line_height = 1.05

-- Return config
return config
