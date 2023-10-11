local wezterm = require("wezterm")

config = wezterm.config_builder()

config.font = wezterm.font("Hack")
config.font_size = 12.0

config.default_cursor_style = "BlinkingBlock"
-- config.default_cursor_style = "BlinkingBar"
config.default_prog = { "fish", "-l" }
config.animation_fps = 10
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 500

config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = "CursorColor",
}

config.colors = {
  -- The default text color
  foreground = "#d8d8d8",

  -- The default background color
  -- background = "black",
  -- background = "#0f1419";

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "#d8d8d8",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "#000000",

  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  -- For inactive panes
  cursor_border = "#52ad70",

  -- the foreground color of selected text
  selection_fg = "black",
  -- the background color of selected text
  selection_bg = "#fffacd",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "#222222",

  -- The color of the split lines between panes
  ansi = {
    "#181818",
    "#ab4642",
    "#a1b56c",
    "#f7ca88",
    "#7cafc2",
    "#ba8baf",
    "#86c1b9",
    "#d8d8d8",
  },
  brights = {
    "#585858",
    "#ab4642",
    "#a1b56c",
    "#f7ca88",
    "#7cafc2",
    "#ba8baf",
    "#86c1b9",
    "#d8d8d8",
  },
  -- visual_bell = "#202020",
  split = "#444444",
}

-- Split bar thicknes
config.underline_thickness = 3

config.use_fancy_tab_bar = false

-- config.enable_scroll_bar = false
config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

config.tab_bar_at_bottom = true

config.hide_tab_bar_if_only_one_tab = true

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- config.freetype_load_target = "HorizontalLcd"

config.keys = {
  {
    key = "q",
    mods = "CTRL",
    action = wezterm.action.SpawnCommandInNewWindow({}),
  },
  {
    key = "v",
    mods = "ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "x",
    mods = "ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "z",
    mods = "ALT",
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = "z",
    mods = "ALT",
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = "w",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Next"),
  },
  {
    key = "T",
    mods = "ALT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "t",
    mods = "ALT",
    action = wezterm.action.ActivateTabRelative(1),
  },
  { key = "a", mods = "ALT", action = wezterm.action.ShowTabNavigator },
}
return config
