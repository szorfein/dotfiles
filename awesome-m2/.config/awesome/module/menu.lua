local beautiful = require("beautiful")
local awful = require("awful")
local gtable = require("gears.table")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- -- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- default config
beautiful.menu_fg_normal = M.x.on_surface
beautiful.menu_bg_normal = M.x.surface
beautiful.menu_fg_focus = M.x.on_primary
beautiful.menu_bg_focus = M.x.primary

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end},
  { "manual", terminal_cmd .. "man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() exit_screen_show() end}
}

local myappmenu = {
  { "ncmpcpp", terminal .. terminal_args[1] .. "music_n" .. terminal_args[2] .. "ncmpcpp" },
  { "cava", terminal .. terminal_args[1] .. "music_c" .. terminal_args[2] .. "cava" },
  { "web", web_browser },
  { "virtualbox", "firejail VirtualBox" },
  { "weechat", terminal .. terminal_args[1] .. "chat" .. terminal_args[2] .. "weechat" },
  { "mutt", terminal .. terminal_args[1] .. "mail" .. terminal_args[2] .. "mutt" },
  { "ranger", terminal_cmd .. "ranger" },
  { "gimp", gimp }
}

local mypentestmenu = {
  { "metasploit", terminal_cmd .. "msf" },
  { "leaked", terminal_cmd .. "leaked.py" },
  { "burpsuite", burpsuite }
}

local mygamemenu = {
  { "baldur's gate 1", "" },
  { "baldur's gate 2", "" },
  { "don't starve", "" }
}

local mymainmenu = awful.menu({ items = 
  {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal },
    { "apps", myappmenu },
    { "pentest tools", mypentestmenu },
    { "games", mygamemenu }
  }
})

-- Mouse bindings
root.buttons(gtable.join(
  awful.button({}, 3, function () mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

return mymainmenu
