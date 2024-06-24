-- ---------------------------------------------------------------------
-- ~/.dotfiles/.wezterm.lua
-- Mark Spain
-- ---------------------------------------------------------------------

-- pull in the wezterm API
local wezterm = require("wezterm")

-- Ttis will hold the configuration
local config = wezterm.config_builder()

-- change the color scheme
config.color_scheme = 'Dracula+'

-- set the font
config.font = wezterm.font("SauceCodePro NFM")
config.font_size = 19

-- set the cursor style
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"

-- set window options
config.initial_cols = 128
config.initial_rows = 32
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.enable_scroll_bar = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 8
-- set startup position
wezterm.on("gui-startup", function(cmd)
   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
   window:gui_window():set_position(300, 300)
end)

-- set keybindings
config.keys = {
  {
    key = 'm',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  }
}

-- return the configuration to wezterm
return config
