local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require('util.widgets')
local font = require("util.font")

-- for the top
local ram = require("widgets.ram")({ 
  mode = "progressbar", layout = "vertical", bar_size = 40,
  title = { "RAM", M.x.primary_variant_1 },
  bar_colors = "#3e7f80"
})

local volume = require("widgets.volume")({ 
  mode = "progressbar", layout = "vertical", bar_size = 40, 
  title = { "VOL", M.x.secondary_variant_2 },
  bar_colors = "#3e6a80"
})

local brightness = require("widgets.brightness")({ 
  mode = "progressbar", layout = "vertical", bar_size = 40,
  title = { "BRI", M.x.primary_variant_2 },
  bar_colors = "#473e80"
})

local battery = require("widgets.battery")({
  mode = "progressbar", layout = "vertical",  bar_size = 40,
  title = { "BAT", M.x.primary },
  bar_colors = "#673e80"
})

-- bottom (monitor bar)
local cpu = require("widgets.cpu")({ 
  title = { "CPU", M.x.secondary_variant_1 },
  mode = "dotsbar", layout = "vertical"
})

local disk = require("widgets.disks")({
  mode = "block", layout = "vertical",
  title = { "FS", M.x.error },
  bar_colors = { "#855789", "#7155a9", "#3f63a0" }
})

local network = require("widgets.network")({
  mode = "block", layout = "vertical",
  title = { "NET", M.x.secondary }, title_size = 20,
  bar_colors = { M.x.primary , M.x.secondary }
})

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- bottom bar
  s.monitor_bar = awful.wibar({ position = "bottom", height = dpi(80), screen = s })
  s.monitor_bar.bg = beautiful.wibar_bg

  -- widget to decorate 
  local boxes = function(w)
    return wibox.widget {
      { -- margin top, bottom
        { -- left
          font.caption("", M.x.primary), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        { -- center
          w,
          left = 20,
          right = 20,
          widget = wibox.container.margin
        },
        { -- right
          font.caption("", M.x.secondary), nil, nil, -- top
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal
      },
      top = 2, bottom = 2,
      left = 8, right = 8,
      widget = wibox.container.margin
    }
  end

  s.monitor_bar:setup {
    nil,
    {
      boxes(cpu),
      boxes(network),
      boxes(volume),
      boxes(disk),
      boxes(ram),
      boxes(battery),
      boxes(brightness),
      --spacing = beautiful.widget_spacing,
      layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
  }
end

return mybar
