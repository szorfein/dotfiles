local awful = require('awful')
local wibox = require('wibox')

local widget = class()

function widget:init(args)
  self.height = args.height or dpi(80) -- display at least 3 lines
  self:quote()
  self:author()
  self:signals()
  return wibox.widget {
    {
      self.quote,
      {
        nil,
        nil,
        self.author,
        expand = 'none',
        layout = wibox.layout.align.horizontal,
      },
      spacing = dpi(18),
      layout = wibox.layout.fixed.vertical
    },
    margins = dpi(22),
    widget = wibox.container.margin
  }
end

function widget:quote()
  self.quote = wibox.widget {
    text = '',
    wrap = 'word_char',
    ellipsize = 'end',
    forced_height = self.height,
    layout = wibox.widget.textbox
  }
end

function widget:author()
  self.author = wibox.widget {
    text = '',
    layout = wibox.widget.textbox
  }
end

function widget:signals()
  awesome.connect_signal("daemon::quote", function(quote, author)
    if quote and author then
      self.quote.text = quote
      self.author.text = '- ' .. author
    end
  end)
end

return widget
