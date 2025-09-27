---------------------------
-- Anonymous awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gears = require("gears")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/layouts/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. M.name .. "/taglist/"

-- screen size
local ascreen = require("awful.screen")
local screen_width = ascreen.focused().geometry.width
local screen_height = ascreen.focused().geometry.height

local theme = {}

theme.fg_normal     = M.x.on_background
theme.fg_focus      = M.x.primary
theme.fg_urgent     = M.x.error
theme.fg_minimize   = M.x.secondary

theme.border_width  = dpi(3)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(5)
theme.border_focus  = M.x.background .. M.e.dp01

-- general padding
theme.general_padding = { left = dpi(6), right = dpi(6), top = dpi(6), bottom = dpi(6) }

-- rounded corners
theme.border_radius = dpi(8)

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = M.x.on_background
theme.titlebar_bg_normal = M.x.background
theme.titlebar_fg_focus = M.x.primary
theme.titlebar_bg_focus = M.x.background
theme.titlebars_enabled = true 
theme.titlebar_title_enabled = true 
theme.titlebars_imitate_borders = false

-- }}} End TITLEBAR

-- Top bar
theme.wibar_size = dpi(50)
theme.wibar_width = screen_width - dpi(126)

theme.wibar_bg = M.x.background .. "00"
theme.wibar_border_radius = dpi(0)

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
    theme.snap_border_width = dpi(8)
else
    theme.snap_border_width = dpi(theme.border_width * 2)
end

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}

-- icon_taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- {{{ MENU

theme.menu_submenu_icon = themes_path..M.name.."/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

theme.wallpaper = os.getenv("HOME") .. "/images/"..M.name..".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, M.x.dark_primary, M.x.primary
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ Tasklist

theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_width = dpi(90)
theme.tasklist_shape = function(cr, width, height) gears.shape.transform(gears.shape.rounded_rect) : translate(0,40) (cr, width, -1, 4) end 
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = "#8a0050"
theme.tasklist_shape_border_color_focus = "#af0366"
theme.tasklist_spacing = dpi(4)
theme.tasklist_align = "center"

-- }}} End Tasklist

-- {{{ WIDGET

-- popup
theme.widget_popup_padding = dpi(3)

-- Mails
theme.widget_email_layout = 'vertical' -- horizontal or vertical

-- Wifi str
theme.widget_wifi_layout = 'vertical' -- horizontal or vertical

-- RAM
theme.widget_ram_layout = 'vertical' -- horizontal or vertical

-- Battery
theme.widget_battery_layout = 'vertical' -- horizontal or vertical

-- Volume
theme.widget_volume_layout = 'vertical' -- horizontal or vertical

-- Date
theme.widget_date_layout = 'vertical' -- horizontal or vertical

-- Change theme
theme.widget_change_theme_layout = 'vertical' -- horizontal or vertical

-- progressbar colors
theme.bar_color = M.x.primary
theme.bar_colors_disk = { M.x.primary, M.x.primary, M.x.primary }
theme.bar_colors_network = { M.x.primary, M.x.primary }

-- }}} End WIDGET

return theme
