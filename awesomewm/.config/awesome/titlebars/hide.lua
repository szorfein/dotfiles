local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local titlebar = require("util.titlebar")

beautiful.titlebar_bg_focus = M.x.background
beautiful.titlebar_bg = M.x.background
beautiful.titlebar_bg_normal = M.x.background

client.connect_signal("request::titlebars", function(c)
    -- bottom bar for ncmpcpp
    if c.class == "music_n" then
      titlebar.ncmpcpp(c, 50)
    end
end)
