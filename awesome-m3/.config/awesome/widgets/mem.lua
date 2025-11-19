local wibox = require('wibox')
local card = require('lib.card-elevated')

local mem = class()

function mem:init(args)
  self.color = md.sys.color.tertiary
  self.radial = self:radial()
  self.width = args.w or dpi(80)
  self.height = args.h or dpi(80)
  self:signals()
  return card:elevated(self:widget())
end

function mem:widget()
  return wibox.widget {
    {
      {
        {
          text = '󰍛',
          align = 'center',
          font = md.sys.typescale.icon.font .. ' ' .. dpi(22),
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

function mem:radial()
  return wibox.widget {
    min_value = 1,
    max_value = 100,
    value = tonumber(self.value),
    border_width = dpi(4),
    color = self.color,
    border_color = self.color .. md.sys.elevation.level2,
    widget = wibox.container.radialprogressbar
  }
end

function mem:signals()
  awesome.connect_signal('daemon::mem', function(mem)
    self.radial.value = mem and tonumber(mem) or 0
  end)
end

return mem
