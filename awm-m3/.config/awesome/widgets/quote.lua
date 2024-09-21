local awful = require('awful')
local wibox = require('wibox')

local textbox = awful.widget {
  text = '',
  layout = wibox.widget.textbox
}

local textbox_author = awful.widget {
  text = '',
  layout = wibox.widget.textbox
}

local quote_widget = awful.widget {
  textbox,
  textbox_author,
  layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal("daemon::quote", function(quote, author)
  if quote and author then
    textbox.text = quote
    textbox_author.text = author
  end
end)

return quote_widget
