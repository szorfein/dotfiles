---------------------------
-- Miami awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gshape = require("gears.shape")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/layouts/"
local xrdb = xresources.get_current_theme()
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/taglist/"

local theme = {}

theme.border_width  = dpi(3)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(14)
theme.border_normal = M.x.background
theme.border_focus  = M.x.background
theme.border_radius = dpi(8)

-- general padding
theme.general_padding = { left = dpi(10), right = dpi(10), top = dpi(10), bottom = dpi(10) }

-- smart border
theme.double_border = true
theme.double_border_normal = M.x.background
theme.double_border_focus = M.x.on_background .. M.e.dp01

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = M.x.on_background
theme.titlebar_bg_normal = M.x.background
theme.titlebar_fg_focus = M.x.on_background
theme.titlebar_bg_focus = M.x.background
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = true
theme.titlebar_buttons_enabled = true
theme.titlebars_imitate_borders = true 
theme.titlebars_imitate_borders_size = 2
theme.titlebar_size = dpi(20)
-- }}} End TITLEBAR

-- Top bar
theme.wibar_height = dpi(45)
theme.wibar_bg = M.x.background .. "ef"
theme.wibar_border_radius = dpi(0)

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}

-- different color on each taglists
theme.taglist_text_color_empty = {
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
  M.x.on_background .. M.e.dp06,
}

theme.taglist_text_color_occupied = {
  M.x.secondary .. "66",
  M.x.secondary .. "69",
  M.x.secondary .. "6B",
  M.x.secondary .. "6E",
  M.x.secondary .. "70",
  M.x.secondary .. "73",
  M.x.secondary .. "75",
  M.x.secondary .. "78",
  M.x.secondary .. "7A",
  M.x.secondary .. "7D",
}

theme.taglist_text_color_focused = {
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
  M.x.primary,
}

theme.taglist_text_color_urgent = {
  M.x.error .. "66",
  M.x.error .. "69",
  M.x.error .. "6B",
  M.x.error .. "6E",
  M.x.error .. "70",
  M.x.error .. "73",
  M.x.error .. "75",
  M.x.error .. "78",
  M.x.error .. "7A",
  M.x.error .. "7B",
}

-- }}} TAGLIST END

theme.tasklist_bg_normal = M.x.background .. M.e.dp00
theme.tasklist_fg_normal = M.x.on_background .. "B3" -- 70%
theme.tasklist_bg_focus = M.x.background .. M.e.dp00
theme.tasklist_fg_focus = M.x.on_background

-- {{{ MENU

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

theme.wallpaper = os.getenv("HOME").."/images/"..M.name..".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ WIDGETS

theme.widget_spacing = dpi(19) -- space between each widgets
-- popup (distance between the bar and the popup, 0 is pasted at the bar)
theme.widget_popup_padding = dpi(3)


-- progressbar colors
theme.bar_color = M.x.primary
theme.bar_colors_disk = { M.x.primary, M.x.primary, M.x.primary }
theme.bar_colors_network = { M.x.primary, M.x.primary }

-- }}} End WIDGET

return theme
