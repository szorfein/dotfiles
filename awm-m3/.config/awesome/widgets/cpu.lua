local wibox = require('wibox')

local cpu = class()

function cpu:init()
  self.radial = self:radial()
  self.cpu_value = '70'
  self:signals()
  return wibox.widget {
    {
      {
        text = 'cpu',
        align = 'center',
        font = md.sys.typescale.label_medium.font
          .. ' ' .. md.sys.typescale.label_medium.size,
        widget = wibox.widget.textbox
      },
      {
        {
          text = self.cpu_value .. '%',
          align = 'center',
          font = md.sys.typescale.body_large.font .. ' ' .. dpi(13),
          forced_height = dpi(80),
          widget = wibox.widget.textbox
        },
        widget = self.radial,
      },
      spacing = dpi(8),
      layout = wibox.layout.fixed.vertical
    },
    margins = dpi(6),
    widget = wibox.container.margin
  }
end

function cpu:radial()
  return wibox.widget {
    min_value = 1,
    max_value = 100,
    value = tonumber(self.cpu_value),
    border_width = dpi(4),
    color = md.sys.color.primary,
    border_color = md.sys.color.on_surface .. md.sys.elevation.level1,
    widget = wibox.container.radialprogressbar
  }
end

function cpu:signals()
  self.radial.value = tonumber(self.cpu_value)
  self.radial:connect_signal('widget::redraw_needed', function()
    self.radial.value = tonumber(self.cpu_value)
  end)
end

return cpu
