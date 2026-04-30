local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = {}

-- Appearance / Window
-- -------------------------------------------------------------

local colors = {
  active = {
    background = { Color = "#b16286" },
    foreground = { Color = "#fbf1c7" },
  },
  hover = {
    background = { Color = "#665c54" },
    foreground = { Color = "#fbf1c7" },
  },
  inactive = {
    background = { Color = "#3c3836" },
    foreground = { Color = "#fbf1c7" },
  },
}

local characters = {
  left_edge = wezterm.nerdfonts.ple_left_half_circle_thick,
  right_edge = wezterm.nerdfonts.ple_right_half_circle_thick,
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.8
config.window_frame = {
  font = wezterm.font('UDEV Gothic 35NF'),
  font_size = 14,
}
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 0,
}

config.use_fancy_tab_bar = true
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

--config.hide_tab_bar_if_only_one_tab = true
--config.show_new_tab_button_in_tab_bar = false
--config.show_close_tab_button_in_tabs = false

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local status = tab.is_active and "active" or (hover and "hover" or "inactive")
  local title = "  " ..
      tab.tab_index + 1 .. ": " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "  "

  return {
    { Background = { Color = "none" } },
    { Foreground = colors[status].background },
    { Text = characters.left_edge },

    { Background = colors[status].background },
    { Foreground = colors[status].foreground },
    { Text = title },

    { Background = { Color = "none" } },
    { Foreground = colors[status].background },
    { Text = characters.right_edge },
  }
end)

-- Appearance / Terminal
-- -------------------------------------------------------------

config.color_scheme = 'Japanesque'
--config.color_scheme = 'GruvboxDark'
config.font = wezterm.font 'HackGen Console NF'
config.font_size = 17

config.enable_scroll_bar = true

-- Key Bindings
-- -------------------------------------------------------------

config.send_composed_key_when_left_alt_is_pressed = false
config.keys = {
  {
    key = "¥",
    action = wezterm.action.SendKey { key = '\\' }
  },
  {
    key = "¥",
    mods = 'ALT',
    action = wezterm.action.SendKey { key = '¥' },
  },
  {
    -- Shift + Enter で LF (\n) を送信 (Claude code で改行できる)
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString('^J'),
  },
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.SendString("\x1b[9;5u"),
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

return config
