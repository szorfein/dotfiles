---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require('gears')
local dpi = xresources.apply_dpi
local helpers = require('lib.helpers')

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = md.sys.typescale.body_medium.font
  .. ' ' .. md.sys.typescale.body_medium.size

theme.bg_normal     = md.sys.color.background
theme.bg_focus      = md.sys.color.on_background .. md.sys.elevation.level1
theme.bg_urgent     = md.sys.color.tertiary
theme.bg_minimize   = md.sys.color.on_surface .. md.sys.state.disable_container_opacity
theme.bg_systray    = md.sys.color.background

theme.fg_normal     = md.sys.color.on_background
theme.fg_focus      = md.sys.color.on_background
theme.fg_urgent     = md.sys.color.on_tertiary
theme.fg_minimize   = md.sys.color.on_surface .. md.sys.state.disable_content_opacity

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(1)
theme.border_normal = md.sys.color.shadow
theme.border_focus  = md.sys.color.surface_variant
theme.border_marked = md.sys.color.inverse_surface

-- Generate taglist squares:
local taglist_square_size = dpi(8)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, md.sys.color.error
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, md.sys.color.error
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- m3 spec: https://awesomewm.org/doc/api/libraries/awful.menu.html
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(30) -- material use 48, a bit too high
theme.menu_width = dpi(180)
theme.menu_font = md.sys.typescale.label_large.font
theme.menu_fg_normal = md.sys.color.on_surface
theme.menu_bg_normal = md.sys.color.surface_container
theme.menu_fg_focus = md.sys.color.on_secondary_container
theme.menu_bg_focus = md.sys.color.secondary_container

theme.wallpaper = md.wallpaper

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
