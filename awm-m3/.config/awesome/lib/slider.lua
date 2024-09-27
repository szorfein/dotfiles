local wibox = require('wibox')
local helpers = require('lib.helpers')
local shape = require('gears.shape')
--local snackbar = require('lib.snackbar')
local spawn = require('awful.spawn')

-- https://m3.material.io/components/sliders/specs
-- Actually, it not look as espected, hard to do with the actual awesome API
-- (not git version)

local slider = class()

function slider:init(args)
  self.args = args or {}
  self.fg = self.args.fg or md.sys.color.primary
  self.bg = self.args.bg or md.sys.color.primary_container
  self.height = self.args.height or dpi(44) -- use the handle height size
  self.on_change = self.args.on_change or nil
  self.shape = helpers.rrect(dpi(26))
  self.value = 30
  self:slider()
  self:progressbar()
  self:signals()

end

function slider:slider()
  self.slider = wibox.widget {
    value = self.value,
    min_value = 1,
    max_value = 100,
    --bar_margins = { top = dpi(14), bottom = dpi(14) },
    bar_height = self.height,
    bar_color = self.fg .. md.sys.elevation.level0,
    bar_shape = self.shape,
    handle_color = self.fg,
    handle_shape = helpers.rrect(dpi(20)),
    handle_border_width = 4,
    handle_border_color = self.fg,
    handle_width  = dpi(4),
    handle_margins = { left = dpi(8), right = dpi(8) },
    forced_height = self.height,
    widget = wibox.widget.slider,
  }
end

function slider:progressbar()
  self.progressbar = wibox.widget {
    value = self.value,
    min_value = 1,
    max_value = 100,
    forced_height = self.height,
    paddings = dpi(4),
    color = self.fg,
    background_color = self.bg .. md.sys.elevation.level2,
    shape = self.shape,
    widget = wibox.widget.progressbar,
  }
end

function slider:widget()
  return wibox.widget {
    self.slider,
    self.progressbar,
    layout = wibox.layout.stack
  }
end

function slider:signals()
  self.slider:connect_signal("property::value", function(widget)
    self:set(widget.value)
  end)
end

function slider:set(value)
  self.value = value
  self.slider.value = value
  self.progressbar.value = value
  if self.on_change then
    --spawn.with_shell(self.on_change .. widget.value)
    spawn.with_shell(self.on_change .. value)
  end
end

function slider:get()
  return self.slider.value
end

return slider
