local wibox = require('wibox')
local card = require('lib.card-elevated')

local mem = class()

function mem:init(args)
  self.radial = self:radial()
  self.value = '70'
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
          text = 'mem',
          align = 'center',
          font = md.sys.typescale.label_medium.font
            .. ' ' .. md.sys.typescale.label_medium.size,
          widget = wibox.widget.textbox
        },
        fg = md.sys.color.on_surface_variant,
        widget = wibox.container.background
      },
      {
        {
          text = self.value .. '%',
          align = 'center',
          font = md.sys.typescale.body_large.font .. ' ' .. dpi(13),
          forced_height = self.height,
          forced_width = self.width,
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

function mem:radial()
  return wibox.widget {
    min_value = 1,
    max_value = 100,
    value = tonumber(self.value),
    border_width = dpi(4),
    color = md.sys.color.tertiary,
    border_color = md.sys.color.on_surface .. md.sys.elevation.level1,
    widget = wibox.container.radialprogressbar
  }
end

function mem:signals()
  self.radial.value = tonumber(self.value)
  self.radial:connect_signal('widget::redraw_needed', function()
    self.radial.value = tonumber(self.value)
  end)
end

return mem
