local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
--local helpers = require('lib.helpers')
local slider = require('lib.slider')

local brightness = class()

function brightness:init()
  self.slider = slider({ on_change = 'light -S ' })
  self.slider_widget = self.slider:widget()
  self.widget = self:create()
  self:buttons()
  self:signals()
  return self.widget
end

function brightness:create()
  return wibox.widget {
    self.slider_widget,
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

function brightness:signals()
  awesome.connect_signal('daemon::brightness', function(brightness)
    self.slider:set(brightness)
  end)
end

function brightness:buttons()
  self.widget:buttons(
    gears.table.join(
      -- Scroll up - Increase brightness
      awful.button({}, 4, function()
        awful.spawn.with_shell("light -A 4")
      end),
      -- Scroll down - Decrease brightness
      awful.button({}, 5, function()
        awful.spawn.with_shell("light -U 4")
      end)
    )
  )
end

return brightness
