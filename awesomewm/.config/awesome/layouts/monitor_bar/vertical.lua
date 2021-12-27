local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local font = require("util.font")
local button = require("utils.button")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")

-- Setting titles
local monitors_title = wibox.widget {
  ufont.body_1("Monitor", "left"),
  widget = mat_text({ color = M.x.on_surface, lv = "medium" })
}

local settings_title = wibox.widget {
  ufont.body_1("Settings", "left"),
  widget = mat_text({ color = M.x.on_surface, lv = "medium" })
}

-- import widgets
local vol = require("widgets.volume")({ mode = "slider" })
local brightness = require("widgets.brightness")({ mode = "slider" })
local cpu = require("widgets.cpu")({ mode = "arcchart" })
local ram = require("widgets.ram")({ mode = "arcchart" })
local disks = require("widgets.disks")({ mode = "arcchart" })

local mybar = class()

function mybar:init(s)

  s.monitor_bar = awful.wibar({ stretch = false, visible = false, type = "dock", screen = s })
  s.monitor_bar.bg = M.x.surface

  -- add an exit button
  local hide_monitor = function ()
    exit_screen_show()
    s.monitor_bar.visible = false
  end
  local exit = button({
    fg_icon = M.x.on_error,
    icon = ufont.button(" LOGOUT"),
    bg = M.x.error,
    mode = "contained",
    command = hide_monitor
  })

  local wibar_pos = beautiful.wibar_position or "top"
  -- place the sidebar at the right position
  if wibar_pos == "left" then
    s.monitor_bar.x = beautiful.wibar_size
    s.monitor_bar.y = 0
    s.monitor_bar.position = "left"
  elseif wibar_pos == "right" then
    s.monitor_bar.position = "right"
  end

  s.monitor_bar.height = awful.screen.focused().geometry.height
  s.monitor_bar.width = dpi(230)

  local textclock = wibox.widget {
    format = '<span foreground="'..M.x.on_surface..'" font="22.5">%H:%M</span>',
    refresh = 60,
    widget = wibox.widget.textclock,
    forced_height = dpi(80),
    forced_width = dpi(90)
  }

  -- a middle click to hide the sidebar
  s.monitor_bar:buttons(gtable.join(
    awful.button({ }, 2, function() 
      s.monitor_bar.visible = false
    end)
  ))

  -- setup
  s.monitor_bar:setup {
    { -- bg
      { -- margin
        widget.centered(textclock), -- top
        { -- center
          monitors_title,
          cpu,
          ram,
          disks,
          spacing = dpi(6),
          layout = wibox.layout.fixed.vertical
        },
        { -- bottom
          settings_title,
          vol,
          brightness,
          widget.centered(exit),
          spacing = 3,
          layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.align.vertical
      },
      left = 12, right = 12, bottom = 6,
      widget = wibox.container.margin
    },
    bg = M.x.on_surface .. M.e.dp01,
    widget = wibox.container.background
  }
end

return mybar
