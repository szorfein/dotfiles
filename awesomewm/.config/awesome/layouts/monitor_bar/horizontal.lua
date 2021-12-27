local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require('util.widgets')
local font = require("util.font")

-- widgets for the monitor bar
local ram = require("widgets.ram")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local volume = require("widgets.volume")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local brightness = require("widgets.brightness")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })
local battery = require("widgets.battery")({ layout = "horizontal", mode = "progressbar", bar_size = 100 })

local cpu = require("widgets.cpu")({ mode = "dotsbar" })
local disk = require("widgets.disks")({ mode = "block" })
local network = require("widgets.network")({ mode = "block" })
local music_player = require("widgets.music-player")({ mode = "block" })

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- bottom bar
  s.monitor_bar = awful.wibar({ position = "bottom", height = dpi(84), screen = s })
  s.monitor_bar.bg = M.x.surface

  -- widget to decorate 
  local boxes = function(w, size)
    local s = size or 200
    return wibox.widget {
      { -- margin top, bottom
        { -- left
          font.button("", M.x.primary, 16), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        { -- center,
          widget.centered(w, "vertical"),
          left = 12, right = 12,
          forced_width = dpi(s),
          widget = wibox.container.margin
        },
        { -- right
          font.button("", M.x.secondary, 16), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal
      },
      top = 1, bottom = 1,
      widget = wibox.container.margin
    }
  end

  local w1 = wibox.widget {
    ram,
    brightness,
    forced_height = 30,
    layout = wibox.layout.fixed.horizontal
  }

  local w2 = wibox.widget {
    volume,
    battery,
    forced_height = 30,
    layout = wibox.layout.fixed.horizontal
  }

  s.monitor_bar:setup {
    nil, -- Left widgets
    {
      boxes(music_player),
      boxes(disk, 250),
      boxes(widget.box('vertical', { w1, w2 }), 300),
      boxes(network, 250),
      { -- the only who need a top margin, idkw
        boxes(cpu),
        top = 10,
        widget = wibox.container.margin,
      },
      spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    nil,  -- Right widgets
    expand ="none",
    layout = wibox.layout.align.horizontal
  }
end

return mybar
