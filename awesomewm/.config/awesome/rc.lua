-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
dpi = beautiful.xresources.apply_dpi -- add dpi globally
-- Notification library
local naughty = require("naughty")

-- Function to create object in lua - used globally
-- return the init function of each class
local function new(self, ...)
  local instance = setmetatable({}, { __index = self })
  return instance:init(...) or instance end

-- Function to create object in lua - used globally
function class(base)
  return setmetatable({ new = new }, { __call = new, __index = base })
end

-- {{{ Variable definitions
M = require("loaded-theme") -- material theme globally

-- Themes define colours, icons, font and wallpapers.
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
beautiful.init( theme_dir .. M.name .. "/theme.lua" )

pcall(require, "config.env") -- user settings globally

local noti = require("utils.noti")

require("module.notifications")
require("module.layout")
require("module.menu")

-- Start daemons
require("daemons")

-- {{{ For each screen
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  require("module.wallpaper")(s)

  -- add padding on all screens
  s.padding = beautiful.general_padding or 0

  -- Each screen has its own tag table.
  require("module.tagnames")(s)

  -- Load extra layouts
  require("layouts")(s)

  -- Create the wibox
  require("bars."..M.name)(s)
end)
-- }}}

-- Start compositor
require("module.autostart")

--require("config.keys")
require("module.rules")
require("titlebars")
require("module.signals")

awful.spawn.easy_async_with_shell("sh -c 'echo "..M.name.." >/tmp/awesome-theme'", function()
  local icon = "<span foreground='" .. M.x.primary .. "'> ※ </span>"
  noti.info(icon .. "theme "..M.name.." is loaded" .. icon)
end)
