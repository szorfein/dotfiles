local awful = require("awful")
local wibox = require("wibox")
local helper = require("utils.helper")

local mybar = class()

function mybar:init(s)

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = require("widgets.layoutbox")(s, {})

  -- Create a taglist widget
  s.mytaglist = require("widgets.mini-taglist")(s, { layout = "vertical" })
 
  -- Create a tasklist widget
  s.mytasklist = require("widgets.mini-tasklist")(s, {})
  
  s.mywibox_vert = awful.wibar({ position = "left", width = dpi(36), screen = s })
  s.mywibox_vert.bg = M.x.background .. "00"

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", height = dpi(36), screen = s })
  s.mywibox.bg = M.x.background .. "00"

  s.mywibox_vert:setup {
    { -- Left widgets
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(4),
      {
        {
          {
            nil,
            {
              s.mytaglist,
              layout = wibox.layout.fixed.vertical
            },
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
          },
          top = 8, bottom = 8,
          widget = wibox.container.margin
        },
        bg = M.x.background .. "E6", -- 90% trans
        shape = helper.rrect(20),
        shape_border_width = 1,
        shape_border_color = M.x.secondary,
        widget = wibox.container.background
      }
    },
    nil,
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  }

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      {
        require("widgets.launcher")(),
        s.mytasklist, -- Middle widget
        layout = wibox.layout.fixed.horizontal
      },
      bg = M.x.background,
      widget = wibox.container.background
    },
    {
      {
        require("widgets.wifi")({ layout = "horizontal", mode = "progressbar" }),
        require("widgets.battery")({ layout = "horizontal", mode = "progressbar" }),
        require("widgets.brightness")({ layout = "horizontal", mode = "progressbar" }),
        layout = wibox.layout.fixed.horizontal
      },
      top = 3,
      bottom = 3,
      widget = wibox.container.margin
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(8),
      wibox.widget.systray(),
      require("widgets.change_theme"),
      require("widgets.settings")(),
      s.mylayoutbox
    }
  }
end

return mybar
