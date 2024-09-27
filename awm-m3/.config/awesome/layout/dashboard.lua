local wibox = require('wibox')
local awful = require('awful')
local helpers = require('lib.helpers')

local function wid(element, width, height)
  return wibox.widget {
    {
      {
        element,
        forced_width = width,
        forced_height = height,
        widget = wibox.container.constraint
      },
      shape = helpers.rrect(dpi(28)),
      bg = md.sys.color.surface,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
  }
end

local dashboard = class()

function dashboard:init(s)
  self.dialog = require('lib.dialog')({
    name = 'dashboard',
    s = s,
    widget = self:content()
  })

  self.dialog:just_centered()
end

function dashboard:content()
  return wibox.widget {
    wid(require('widgets.date')(), dpi(90), dpi(120)),
    wid(require('widgets.calendar')(), dpi(280), dpi(300)),
    wid(require('widgets.quote')({}), dpi(280), dpi(160)),
    spacing = dpi(6),
    layout = wibox.layout.fixed.vertical
  }
end

return dashboard
