---------------------------
--   Sci awesome theme   --
---------------------------

local theme_assets = require("beautiful.theme_assets")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = M.f.overline

theme.bg_normal     = M.x.background
theme.bg_focus      = M.x.dark_primary
theme.bg_urgent     = M.x.error
theme.bg_minimize   = M.x.background
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = M.x.on_background .. "C2" -- 76%
theme.fg_focus      = M.x.on_background
theme.fg_urgent     = M.x.on_error
theme.fg_minimize   = M.x.on_background .. "80" -- 50%

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(6)
theme.border_normal = M.x.background
theme.border_focus  = M.x.dark_primary
theme.border_marked = M.x.error

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Border radius on floating client
theme.border_radius = dpi(10)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = os.getenv("HOME").."/images/sci.jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, M.x.primary, M.x.on_primary
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
