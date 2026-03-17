---------------------------
-- Machine awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gshape = require("gears.shape")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/layouts/"
local wibox = require("wibox")
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/taglist/"
local helpers = require("helpers")

local theme = {}

theme.border_width  = dpi(2)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(5)
theme.border_radius = dpi(11)

-- general padding
theme.general_padding = { left = dpi(9), right = dpi(9), top = dpi(9), bottom = dpi(9) }

-- smart border
theme.double_border = false

-- {{{ TITLEBAR 

theme.titlebar_bg_normal = M.x.primary .. "99" -- 60%
theme.titlebar_bg_focus = M.x.error .. "E6" -- 90%
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = false
theme.titlebar_buttons_enabled = false
theme.titlebar_position = 'left'
theme.titlebars_imitate_borders = false
theme.titlebars_imitate_borders_size = 2
theme.titlebar_size = dpi(12)
-- }}} End TITLEBAR

-- Top bar
theme.wibar_size = dpi(56)
theme.wibar_border_radius = dpi(0)
theme.wibar_position = "left"

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
  theme.snap_border_width = dpi(1)
else
  theme.snap_border_width = dpi(theme.border_width * 1)
end

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}
-- mini_taglist
theme.taglist_text_occupied = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_focused = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_urgent = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}
theme.taglist_text_empty = {"⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘","⭘"}

-- icon_taglist
theme.ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}

-- different color on each taglists
theme.taglist_text_color_empty = {
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
  M.x.background,
}

theme.taglist_text_color_occupied = {
  M.x.primary,
  M.x.secondary,
  M.x.primary,
  M.x.secondary,
  M.x.primary,
  M.x.secondary,
  M.x.primary,
  M.x.secondary,
  M.x.primary,
  M.x.secondary,
}

theme.taglist_text_color_focused = {
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
  M.x.on_background,
}

theme.taglist_text_color_urgent = {
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
  M.x.error,
}

theme.taglist_layout = wibox.layout.fixed.vertical -- horizontal or vertical

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal
)

-- }}} TAGLIST END

-- {{{ MENU

theme.menu_submenu_icon = themes_path..M.name.."/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

theme.wallpaper = os.getenv("HOME") .. "/images/" .. M.name .. ".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ WIDGETS

theme.widget_spacing = dpi(5) -- space between each widgets
-- popup (distance between the bar and the popup, 0 is pasted at the bar)
theme.widget_popup_padding = dpi(3)

theme.widget_change_theme_layout = "vertical"

-- }}} End WIDGET

return theme
