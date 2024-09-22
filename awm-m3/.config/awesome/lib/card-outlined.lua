local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/cards/specs

local card = class()

function card:init(args)
  self.image = args.image or nil
  self.title = args.title or ''
  self.text = args.text or nil
  self.on_click = args.on_click
  self:state()
  self:container_elevation()
  self.widget = wibox.widget {
    {
      {
        {
          self:image_widget(),
          self:title_widget(),
          self:text_widget(),
          spacing = dpi(8),
          layout = wibox.layout.fixed.vertical
        },
        widget = self.state
      },
      widget = self.container_elevation
    },
    widget = self:container()
  }
  self:add_signals()

  return self.widget
end

function card:image_widget()
  if self.image then
    return wibox.widget {
      nil,
      {
        image = self.image,
        forced_height = (self.image and dpi(100) or 0),
        forced_width = (self.image and dpi(180) or 0),
        widget = wibox.widget.imagebox
      },
      expand = 'none',
      layout = wibox.layout.align.horizontal
    }
  else
    return nil
  end
end

function card:title_widget()
  if self.title then
    return wibox.widget {
      {
        text = self.title,
        font = md.sys.typescale.title_medium.font
          .. ' ' .. md.sys.typescale.title_medium.size,
        widget = wibox.widget.textbox
      },
      widget = self:padding()
    }
  else
    return nil
  end
end

function card:text_widget()
  if self.text then
    return wibox.widget {
      {
        text = self.text,
        font = md.sys.typescale.body_medium.font
          .. ' ' .. md.sys.typescale.body_medium.size,
        widget = wibox.widget.textbox
      },
      widget = self:padding()
    }
  else
    return nil
  end
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
    shape_border_color = md.sys.color.outline_variant,
    widget = wibox.container.background
  }
end

function card:state()
  self.state = wibox.widget {
    bg = md.sys.color.on_surface .. '00',
    shape = helpers:rrect(dpi(12)),
    widget = wibox.container.background
  }
end

function card:container_elevation()
  self.container_elevation = wibox.widget {
    bg = md.sys.color.surface_tint_color .. '00',
    shape = helpers:rrect(dpi(12)),
    widget = wibox.container.background
  }
end

function card:add_signals()
  self.widget:connect_signal('mouse::enter', function()
    self.state.bg = md.sys.color.surface_tint_color
      .. md.sys.state.hover_state_layer_opacity
    self.container_elevation.bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level1
  end)
  self.widget:connect_signal('mouse::leave', function()
    self.state.bg = md.sys.color.surface_tint_color .. '00'
    self.container_elevation.bg = md.sys.color.surface_tint_color .. '00'
  end)
  self.widget:connect_signal('button::press', function()
    if self.on_click and type(self.on_click) == 'function' then
      self.on_click()
    end
  end)
end

return card
