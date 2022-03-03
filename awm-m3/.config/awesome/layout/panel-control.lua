local wibox = require('wibox')

local control = class()

function control:init()
  return wibox.widget {
    {
      self:left_side(),
      self:right_side(),
      layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(10),
    widget = wibox.container.margin
  }
end

function control:left_side()
  return wibox.widget {
    self:monitoring(),
    {
      self:centered({
        require('widgets.brightness')({}),
        require('widgets.volume')({})
      }),
      self:centered({
        require('widgets.cpu')({ w = dpi(80), h = dpi(80) }),
      }),
      self:centered({
        require('widgets.mem')({ w = dpi(80), h = dpi(80) })
      }),
      spacing = dpi(14),
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.align.vertical
  }
end

function control:centered(widgets)
  local widget = wibox.widget {
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal
  }
  for _,v in ipairs(widgets) do widget:add(v) end
  return wibox.widget {
    nil,
    {
      widget,
      layout = wibox.layout.fixed.horizontal
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

function control:monitoring()
  return wibox.widget {
    {
      text = 'BATTERY',
      widget = wibox.widget.textbox
    },
    {
      text = ' xxxxxx',
      widget = wibox.widget.textbox
    },
    {
      text = 'USEDRAM',
      widget = wibox.widget.textbox
    },
    {
      text = ' xxxxxx',
      widget = wibox.widget.textbox
    },
    {
      text = 'USEDSTO',
      widget = wibox.widget.textbox
    },
    {
      text = ' xxxxxx',
      widget = wibox.widget.textbox
    },
    {
      text = 'STOPPED',
      widget = wibox.widget.textbox
    },
    {
      text = ' xxxxxx',
      widget = wibox.widget.textbox
    },
    {
      text = 'USEDCPU',
      widget = wibox.widget.textbox
    },
    {
      text = ' xxxxxx',
      widget = wibox.widget.textbox
    },
    spacing = dpi(8),
    layout = wibox.layout.fixed.vertical
  }
end

function control:letter(char, font, fg)
  return wibox.widget {
    {
      text = char,
      font = font,
      align = 'center',
      forced_height = dpi(45),
      widget = wibox.widget.textbox
    },
    fg = fg,
    widget = wibox.container.background
  }
end

function control:right_side()
  local day = os.date('%a'):upper()
  local month = os.date('%b'):upper()
  local mfont = md.sys.typescale.title_large.font
    .. ' ' .. md.sys.typescale.title_large.size

  local on = md.sys.color.on_surface
  local on_variant = md.sys.color.on_surface_variant
    .. md.sys.state.disable_content_opacity

  return wibox.widget {
    {
      self:letter(day:sub(1,1), mfont, on),
      self:letter(day:sub(2,2), mfont, on),
      self:letter(day:sub(3,3), mfont, on),
      self:letter(month:sub(1,1), mfont, on_variant),
      self:letter(month:sub(2,2), mfont, on_variant),
      self:letter(month:sub(3,3), mfont, on_variant),
      layout = wibox.layout.fixed.vertical
    },
    {
      {
        format = '%R.%p',
        align = 'center',
        font = md.sys.typescale.body_large.font
          .. ' ' .. dpi(14),
        widget = wibox.widget.textclock
      },
      direction = 'west',
      layout = wibox.container.rotate
    },
    require('widgets.quit')(),
    expand = 'none',
    layout = wibox.layout.align.vertical
  }
end

return control
