local wibox = require('wibox')
local helpers = require('lib.helpers')
local gears = require('gears')

-- https://m3.material.io/components/icon-buttons/specs
-- https://m3.material.io/components/icon-buttons/specs#05e02b7f-ebf2-4f02-9709-8230db3702b4
local button = class()

function button:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.text = self.args.text or nil
  self.fg = self.args.fg or md.sys.color.primary
  self.bg = self.args.bg or md.sys.color.surface
  self.cmd = self.args.cmd or nil
  self.state = self:state()
  self.surface = self:surface()
  self.widget = self:outlined()
  self:signals()
  return self.widget
end

function button:outlined()
  return wibox.widget {
    {
      {
        {
          {
            self:make_icon(),
            self:make_text(),
            spacing = self.text and dpi(8) or 0,
            layout = wibox.layout.fixed.horizontal
          },
          widget = self:layout()
        },
        widget = self.state
      },
      widget = self.surface
    },
    widget = self:container()
  }
end

function button:make_icon()
  if not self.icon then return nil end
  return wibox.widget {
    text = self.icon,
    align = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. dpi(18),
    widget = wibox.widget.textbox
  }
end

function button:make_text()
  if not self.text then return nil end
  return wibox.widget {
    text = self.text,
    align = 'center',
    font = md.sys.typescale.label_large.font
      .. ' ' .. md.sys.typescale.label_large.size,
    widget = wibox.widget.textbox
  }
end

function button:container()
  return wibox.widget {
    fg = self.fg,
    bg = self.bg,
    shape = gears.shape.circle,
    shape_border_width = 1,
    shape_border_color = md.sys.color.outlined,
    widget = wibox.container.background
  }
end

function button:surface()
  return wibox.widget {
    bg = self.fg .. md.sys.elevation.level0,
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function button:layout()
  return wibox.widget {
    top = dpi(10),
    bottom = dpi(10),
    left = dpi(16),
    right = dpi(16),
    widget = wibox.container.margin
  }
end

function button:state()
  return wibox.widget {
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function button:signals()
  self.state:connect_signal('mouse::enter', function()
    self.state.bg = self.fg
      .. md.sys.state.hover_state_layer_opacity
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = self.bg .. '00'
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
