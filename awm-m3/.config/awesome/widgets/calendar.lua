local wibox = require('wibox')
local helpers = require('lib.helpers')

local styles = {
  header = { fg_color = md.sys.color.primary },
  normal = {},
  focus = {
    fg_color = md.sys.color.on_secondary_container,
    shape = helpers.rrect(dpi(20)),
    bg_color = md.sys.color.secondary_container,
  }
}

local function decorate_cell(w, flag, date)
  local props = styles[flag] or {}
  if props.markup and w.get_text and w.set_markup then
    w:set_markup(props.markup(w:get_text()))
  end
  return wibox.widget {
    {
      w,
      margins = dpi(5),
      widget  = wibox.container.margin
    },
    shape = props.shape,
    fg = props.fg_color or md.sys.color.on_surface,
    bg = props.bg_color or md.sys.color.surface,
    widget = wibox.container.background
  }
end

local calendar = class()

function calendar:init()
  return wibox.widget {
    {
      date = os.date('*t'),
      fn_embed = decorate_cell,
      font = md.sys.typescale.body_small.font
        .. ' ' .. md.sys.typescale.body_small.size,
      widget = wibox.widget.calendar.month
    },
    margins = dpi(14),
    widget = wibox.container.margin
  }
end

return calendar
