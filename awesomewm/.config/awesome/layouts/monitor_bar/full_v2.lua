local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local font = require("util.font")
local button = require("utils.button")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")

-- import widgets
local cpu = require("widgets.cpu")({ 
  title = { "CPU", M.x.secondary_variant_1 },
  mode = "dotsbar", layout = "vertical"
})

local ram = require("widgets.ram")({ 
  mode = "progressbar", layout = "vertical", bar_size = 40,
  title = { "RAM", M.x.primary_variant_1 },
  bar_colors = "#3e7f80"
})

local disks = require("widgets.disks")({
  mode = "block", layout = "vertical",
  title = { "FS", M.x.error },
  bar_colors = { "#855789", "#7155a9", "#3f63a0" }
})

local mybar = class()

function mybar:init(s)

  s.monitor_bar = wibox({ visible = true, type = "splash", screen = s })
  s.monitor_bar.bg = M.x.surface .. "00"
  -- we need resize the wibox else button on side screen will not work
  s.monitor_bar.width = s.geometry.width * 0.90
  s.monitor_bar.height = s.geometry.height * 0.90
  s.monitor_bar.x = s.geometry.width / 2 - s.geometry.width * 0.90 / 2
  s.monitor_bar.y = s.geometry.height / 2 - s.geometry.height * 0.90 / 2

  -- add an exit button
  local hide_monitor = function ()
    exit_screen_show()
    s.monitor_bar.visible = false
  end

  local dayname = wibox.widget.textclock("%A")
  dayname.font = M.f.h1
  dayname.align = "center"

  local hour = wibox.widget.textclock("%H")
  hour.font = "Cyberpunks Regular 20"
  hour.align = "center"

  local minute = wibox.widget.textclock("%M")
  minute.font = "Cyberpunks Regular 20"
  minute.align = "center"

  local time = wibox.widget {
    nil,
    {
      hour,
      minute,
      layout = wibox.layout.fixed.vertical
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  }

  local day = wibox.widget.textclock("%d")
  day.font = M.f.h6
  day.align = "center"

  local month = wibox.widget.textclock("%B")
  month.font = M.f.h6
  month.align = "center"

  local mydate = wibox.widget {
    nil,
    {
      dayname,
      {
        month,
        day,
        spacing = 30,
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.fixed.vertical
    },
    expand = "none",
    layout = wibox.layout.align.vertical
  }

  -- a middle click to hide the sidebar
  s.monitor_bar:buttons(gtable.join(
    awful.button({ }, 2, function() 
      s.monitor_bar.visible = false
    end)
  ))

  -- setup
  s.monitor_bar:setup {
    nil,
    {
      { -- left
        {
          {
            nil,
            cpu,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
          },
          {
            nil,
            ram,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
          },
          {
            nil,
            disks,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
          },
          spacing = 15,
          forced_width = 220,
          layout = wibox.layout.fixed.vertical
        },
        right = 60,
        widget = wibox.container.margin
      },
      nil,
      { -- right
        {
          time,
          mydate,
          spacing = 30,
          layout = wibox.layout.fixed.horizontal
        },
        nil,
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end

return mybar
