local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = {}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 0,
}
config.window_frame = {
  font = wezterm.font('UDEV Gothic 35NF'),
  font_size = 14,
}
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
config.color_scheme = 'Japanesque'
--config.color_scheme = 'GruvboxDark'
config.window_background_opacity = 0.8
config.font = wezterm.font 'HackGen Console NF'
config.font_size = 17

config.enable_scroll_bar = true

config.send_composed_key_when_left_alt_is_pressed = false
config.keys = {
  {
    key = "¥",
    action = wezterm.action.SendKey { key = '\\' }
  },
  {
    key = 'LeftArrow',
    mods = 'SUPER',
    action = wezterm.action.SendKey { key = 'LeftArrow', mods = 'CTRL' },
  },
  {
    key = 'RightArrow',
    mods = 'SUPER',
    action = wezterm.action.SendKey { key = 'RightArrow', mods = 'CTRL' },
  },
  {
    key = 'UpArrow',
    mods = 'SUPER',
    action = wezterm.action.SendKey { key = 'UpArrow', mods = 'CTRL' },
  },
  {
    key = 'DownArrow',
    mods = 'SUPER',
    action = wezterm.action.SendKey { key = 'DownArrow', mods = 'CTRL' },
  },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#626262"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local edge_background = "none"
  local edge_foreground = background

  local title = "  " .. tab.tab_index + 1 .. ": " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "  "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },

    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },

    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

return config
