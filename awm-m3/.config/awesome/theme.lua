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

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:

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
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.wallpaper = os.getenv('HOME') .. '/images/' .. md.name .. '.jpg'

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
