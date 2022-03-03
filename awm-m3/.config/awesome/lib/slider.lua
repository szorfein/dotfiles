local wibox = require('wibox')
local helpers = require('lib.helpers')

local slider = class()

function slider:init(args)
  self.args = args or {}
  self.fg = self.args.fg or md.sys.color.secondary
  self.bg = self.args.bg or md.sys.color.on_surface
  self.value = 30
  self.slider = self:slider()
  self.progressbar = self:progressbar()
  self:signals()
end

function slider:slider()
  return wibox.widget {
    value = self.value,
    min_value = 1,
    max_value = 100,
    handle_color = self.fg,
    bar_color = md.sys.color.surface,
    handle_shape = helpers:circle(),
    handle_border_width = 10,
    handle_width  = 10,
    bar_shape = helpers.rrect(dpi(26)),
    widget = wibox.widget.slider,
  }
end

function slider:progressbar()
  return wibox.widget {
    value = self.value,
    min_value = 1,
    max_value = 100,
    color = self.fg,
    background_color = self.bg .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(26)),
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
  self.slider:connect_signal("property::value", function()
    self.progressbar.value = self.slider.value
    self.value = self.slider.value
  end)
end

function slider:set(value)
  self.value = self.slider.value
  self.slider.value = value
  self.progressbar.value = value
end

return slider
