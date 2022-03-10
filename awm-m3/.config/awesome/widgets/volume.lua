local wibox = require('wibox')
local awful = require('awful')
local helpers = require('lib.helpers')
local gtable = require('gears.table')
local vol = require('lib.volume')
local slider = require('lib.slider')({ fg = md.sys.color.primary })

local volume = class()

function volume:init()
  self.slider = slider:widget()
  self.widget = self:create()
  self:buttons()
  self:signals()
  return self.widget
end

function volume:create()
  return wibox.widget {
    self.slider,
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

function volume:buttons()
  self.widget:buttons(
    gtable.join(
    -- Scroll up - Increase volume
    awful.button({}, 4, function()
      vol:up()
    end),
    -- Scroll down - Decrease volume
    awful.button({}, 5, function()
      vol:down()
    end)
    )
  )
end

function volume:signals()
  awesome.connect_signal('daemon::volume', function(vol, mute)
    slider:set(tonumber(vol))
  end)
  slider.slider:connect_signal('property::value', function()
    vol:set(slider.slider.value)
  end)
end

return volume
