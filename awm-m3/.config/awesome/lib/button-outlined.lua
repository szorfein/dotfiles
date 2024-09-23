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
  self.fg = self.args.fg or md.sys.color.on_surface_variant
  self.bg = self.args.bg or md.sys.color.surface
  self.cmd = self.args.cmd or nil
  self:state()
  self:container()
  self.widget = self:make_widget()
  self:signals()
  return self.widget
end

function button:make_widget()
  return wibox.widget {
    {
      {
        {
          self:make_icon(),
          self:make_text(),
          spacing = self.text and dpi(8) or 0,
          layout = wibox.layout.fixed.horizontal
        },
        widget = self:margin()
      },
      widget = self.state
    },
    widget = self.container
  }
end

function button:make_icon()
  if not self.icon then return nil end
  return wibox.widget {
    text = self.icon,
    align = 'center',
    valign = 'center',
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
  self.container = wibox.widget {
    fg = self.fg,
    bg = self.bg,
    shape = gears.shape.circle,
    shape_border_width = 1,
    shape_border_color = md.sys.color.outlined,
    widget = wibox.container.background
  }
end


function button:margin()
  return wibox.widget {
    top = dpi(10),
    bottom = dpi(10),
    left = dpi(16),
    right = dpi(16),
    widget = wibox.container.margin
  }
end

function button:state()
  self.state = wibox.widget {
    bg = self.fg .. '00',
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function button:signals()
  self.widget:connect_signal('mouse::enter', function()
    self.state.bg = self.fg
      .. md.sys.state.hover_state_layer_opacity
    self.container.fg = md.sys.color.on_surface_variant
  end)
  self.widget:connect_signal('mouse::leave', function()
    self.state.bg = self.fg .. '00'
    self.container.fg = self.fg
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
