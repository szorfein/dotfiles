local wibox = require('wibox')

local cpu = class()

function cpu:init(args)
  self.color = md.sys.color.primary
  self.radial = self:radial()
  self.width = args.w or dpi(80)
  self.height = args.h or dpi(80)
  self:signals()
  return self:widget()
end

function cpu:widget()
  return wibox.widget {
    {
      {
        {
          text = '󰘚',
          font = md.sys.typescale.icon.font .. ' ' .. dpi(22),
          align = 'center',
          forced_height = self.height,
          forced_width = self.width,
          widget = wibox.widget.textbox
        },
        fg = self.color,
        widget = wibox.container.background
      },
      widget = self.radial,
    },
    spacing = dpi(8),
    layout = wibox.layout.fixed.vertical
  }
end

function cpu:radial()
  return wibox.widget {
    min_value = 1,
    max_value = 100,
    value = 10,
    border_width = dpi(4),
    color = self.color,
    border_color = self.color .. md.sys.elevation.level2,
    widget = wibox.container.radialprogressbar
  }
end

function cpu:signals()
  awesome.connect_signal('daemon::cpu', function(cpu)
    self.radial.value = cpu and tonumber(cpu) or 0
  end)
end

return cpu
