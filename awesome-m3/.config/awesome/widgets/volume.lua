local wibox = require('wibox')
local awful = require('awful')
local helpers = require('lib.helpers')
local gtable = require('gears.table')
local vol = require('lib.volume')
local slider = require('lib.slider')
--local snackbar = require('lib.snackbar')

local volume = class()

function volume:init()
  self.slider = slider({ fg = md.sys.color.secondary,
                         bg = md.sys.color.secondary_container,
                         on_change = '~/.config/awesome/scripts/volume.sh ' })
  self.slider_widget = self.slider:widget()
  self:create()
  self:buttons()
  self:signals()
  return self.widget
end

function volume:create()
  self.widget = wibox.widget {
    self.slider_widget,
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
  awesome.connect_signal('daemon::volume', function(v, mute)
    --snackbar.debug({ title = "from widget "..tostring(v) })
    if mute then
      self.slider:set(v)
    else
      self.slider:set(v)
    end
  end)
end

return volume
