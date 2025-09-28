local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/m3/pages/common-buttons/specs/#0eea2a85-b4d7-4c74-b08e-98410b9412c7
local chip = class()

function chip:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.text = self.args.text or nil
  self.fg = self.args.fg or md.sys.color.on_surface_variant
  self.bg = self.args.bg or md.sys.color.surface
  self.cmd = self.args.cmd or nil
  self.state = self:state()
  self.surface = self:surface()
  self.widget = self:suggestion()
  self:signals()
  return self.widget
end

function chip:suggestion()
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

function chip:make_icon()
  if not self.icon then return nil end
  return wibox.widget {
    text = self.icon,
    align = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. dpi(18),
    widget = wibox.widget.textbox
  }
end

function chip:make_text()
  if not self.text then return nil end
  return wibox.widget {
    text = self.text,
    align = 'center',
    font = md.sys.typescale.label_large.font
      .. ' ' .. md.sys.typescale.label_large.size,
    widget = wibox.widget.textbox
  }
end

function chip:container()
  return wibox.widget {
    fg = self.fg,
    bg = self.bg,
    shape = helpers.rrect(dpi(8)),
    widget = wibox.container.background
  }
end

function chip:surface()
  return wibox.widget {
    bg = md.sys.color.surface_tint_color .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(8)),
    widget = wibox.container.background
  }
end

function chip:layout()
  return wibox.widget {
    top = dpi(6),
    bottom = dpi(6),
    left = dpi(16),
    right = dpi(16),
    widget = wibox.container.margin
  }
end

function chip:state()
  return wibox.widget {
    shape = helpers.rrect(dpi(8)),
    widget = wibox.container.background
  }
end

function chip:signals()
  self.state:connect_signal('mouse::enter', function()
    self.state.bg = self.fg
      .. md.sys.state.hover_state_layer_opacity
    self.surface.bg = md.sys.color.surface_tint_color .. md.sys.elevation.level2
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = self.bg .. '00'
    self.surface.bg = md.sys.color.surface_tint_color .. md.sys.elevation.level1
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return chip
