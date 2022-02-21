local wibox = require('wibox')

local date = class()

function date:init()
  self.w = wibox.widget {
    nil,
    {
      {
        {
          self:day(),
          fg = md.sys.color.primary,
          widget = wibox.container.background
        },
        {
          self:month(),
          fg = md.sys.color.secondary,
          widget = wibox.container.background
        },
        layout = wibox.layout.fixed.vertical
      },
      margins = dpi(16),
      widget = wibox.container.margin,
    },
    expand = 'none',
    layout = wibox.layout.align.vertical
  }
end

function date:day()
  local w = wibox.widget.textclock('%d')
  w.align = 'left'
  w.font = md.sys.typescale.body_large.font
    .. ' ' .. md.sys.typescale.body_large.size
  
  return w
end

function date:month()
  local w = wibox.widget.textclock('%B')
  w.text = w.text:sub(1,3)
  w.align = 'right'
  w.font = md.sys.typescale.body_large.font
    .. ' ' .. md.sys.typescale.body_large.size
  
  return w
end

local main = class(date)

function main:init()
  date.init(self)
  return self.w
end

return main
