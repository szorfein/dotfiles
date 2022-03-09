local wibox = require('wibox')
local helpers = require('lib.helpers')

local control = class()

function control:init()
  self.mem = self:progressbar(5)
  self.cpu = self:progressbar(5)
  self.geoloc = self:geoloc()
  self:signals()
  return wibox.widget {
    {
      self:left_side(),
      self:right_side(),
      layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(12),
    widget = wibox.container.margin
  }
end

function control:signals()
  awesome.connect_signal('daemon::mem', function(mem)
    self.mem.value = mem and tonumber(mem) or 0
  end)
  awesome.connect_signal('daemon::cpu', function(cpu)
    self.cpu.value = cpu and tonumber(cpu) or 0
  end)
  awesome.connect_signal('daemon::geoloc', function(country, city)
    local country = country and tostring(country) or nil
    local city = city and tostring(city) or 'Somewhere'
    self.geoloc.text = city .. ', ' .. country
  end)
end

function control:left_side()
  local day = os.date('%e')
  return wibox.widget {
    { -- top
      {
        {
          {
            text = day,
            align = 'left',
            font = md.sys.typescale.display_large.font
              .. ' ' .. md.sys.typescale.display_large.size,
            widget = wibox.widget.textbox
          },
          {
            text = 'TH',
            valign = 'top',
            widget = wibox.widget.textbox
          },
          forced_height = md.sys.typescale.display_large.size,
          layout = wibox.layout.fixed.horizontal
        },
        bottom = dpi(8),
        widget = wibox.container.margin
      },
      self:centered({
        self:monitoring(),
      }),
      layout = wibox.layout.fixed.vertical
    },
    { -- middle
      nil,
      self:centered({
        require('widgets.brightness')({}),
        require('widgets.volume')({})
      }),
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    { -- bottom
      self:centered({
        require('widgets.cpu')({ w = dpi(80), h = dpi(80) }),
      }),
      self:centered({
        require('widgets.mem')({ w = dpi(80), h = dpi(80) })
      }),
      spacing = dpi(14),
      layout = wibox.layout.fixed.vertical
    },
    expand = 'none',
    forced_width = dpi(160),
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

function control:progressbar(value)
  return wibox.widget {
    max_value     = 1,
    value         = value,
    max_value     = 100,
    forced_height = 10,
    forced_width  = 100,
    paddings      = 1,
    border_width  = 1,
    border_color  = md.sys.color.shadow,
    color = md.sys.color.primary,
    background_color = md.sys.color.primary
      .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(20)),
    widget        = wibox.widget.progressbar,
  }
end

function control:monitoring()
  return wibox.widget {
    {
      text = 'BATTERY',
      widget = wibox.widget.textbox
    },
    {
      widget = self:progressbar(70),
    },
    {
      text = 'USEDRAM',
      widget = wibox.widget.textbox
    },
    self.mem,
    {
      text = 'USEDSTO',
      widget = wibox.widget.textbox
    },
    {
      widget = self:progressbar(10),
    },
    {
      text = 'CPU',
      widget = wibox.widget.textbox
    },
    self.cpu,
    {
      {
        text = '󱘈',
        font = md.sys.typescale.icon.font .. ' ' .. dpi(16),
        widget = wibox.widget.textbox
      },
      self.geoloc,
      spacing = dpi(8),
      layout = wibox.layout.fixed.horizontal
    },
    spacing = dpi(8),
    layout = wibox.layout.fixed.vertical
  }
end

function control:geoloc()
  return wibox.widget {
    text = 'city, country',
    widget = wibox.widget.textbox
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
        {
          text = '󱑂',
          font = md.sys.typescale.icon.font .. ' ' .. dpi(18),
          widget = wibox.widget.textbox
        },
        {
          format = '%R.%p',
          align = 'center',
          font = md.sys.typescale.body_large.font
          .. ' ' .. dpi(14),
          widget = wibox.widget.textclock
        },
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
      },
      direction = 'west',
      layout = wibox.container.rotate
    },
    require('widgets.quit')(),
    expand = 'none',
    fixed_width = dpi(85),
    layout = wibox.layout.align.vertical
  }
end

return control
