local wibox = require('wibox')
local helpers = require('lib.helpers')

local card = class()

function card:init(args)
  self.title = args.title or ''
  self.image = args.image or nil
  self.on_click = args.on_click
  self.state = self:state()
  self.widget = wibox.widget {
    {
      {
        {
          nil,
          {
            image = self.image,
            forced_height = (self.image and dpi(100) or 0),
            forced_width = (self.image and dpi(180) or 0),
            widget = wibox.widget.imagebox
          },
          expand = 'none',
          layout = wibox.layout.align.horizontal
        },
        {
          {
            text = self.title,
            font = md.sys.typescale.title_medium.font
              .. ' ' .. md.sys.typescale.title_medium.size,
            widget = wibox.widget.textbox
          },
          widget = self:padding()
        },
        spacing = dpi(8),
        layout = wibox.layout.fixed.vertical
      },
      widget = self.state
    },
    widget = self:container()
  }
  self:add_signals()

  return self.widget
end

function card:padding()
  return wibox.widget {
    margins = dpi(16),
    widget = wibox.container.margin
  }
end

function card:container()
  return wibox.widget {
    bg = md.sys.color.surface,
    shape = helpers:rrect(dpi(12)),
    shape_border_width = 1,
    shape_border_color = md.sys.color.outline,
    widget = wibox.container.background
  }
end

function card:state()
  return wibox.widget {
    bg = md.sys.color.on_surface .. '00',
    widget = wibox.container.background
  }
end

function card:add_signals()
  self.state:connect_signal('mouse::enter', function()
    self.state.bg = md.sys.color.on_surface
      .. md.sys.state.hover_state_layer_opacity
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = md.sys.color.on_surface .. '00'
  end)
  self.widget:connect_signal('button::press', function()
    if self.on_click and type(self.on_click) == 'function' then
      self.on_click()
    end
  end)
end

return card
