local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local helpers = require('lib.helpers')
local slider = require('lib.slider')()

local brightness = class()

function brightness:init()
  self.slider = slider:widget()
  self.widget = self:create()
  slider:set(4)
  self:buttons()
  self:signals()
  return self.widget
end

function brightness:create()
  return wibox.widget {
    self.slider,
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

function brightness:signals()
  slider.slider:connect_signal('property::value', function()
    awful.spawn.with_shell('light -S ' .. slider.slider.value)
  end)
  awesome.connect_signal('daemon::brightness', function(brightness)
    slider:set(brightness)
  end)
end

function brightness:buttons()
  self.widget:buttons(
    gears.table.join(
      -- Scroll up - Increase brightness
      awful.button({}, 4, function()
        awful.spawn.with_shell("light -A 5")
      end),
      -- Scroll down - Decrease brightness
      awful.button({}, 5, function()
        awful.spawn.with_shell("light -U 5")
      end)
    )
  )
end

return brightness
