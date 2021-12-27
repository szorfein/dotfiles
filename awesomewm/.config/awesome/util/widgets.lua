local wibox = require("wibox")
local helpers = require("helpers")
local gshape = require("gears.shape")
local gtable = require("gears.table")
local awful = require("awful")
local naughty = require("naughty")
local separator = require("util.separators")
local app = require("util.app")

local widgets = {}

function widgets.create_text(text, fg, font)
  local w = widgets.create_base_text(font)
  w.markup = helpers.colorize_text(text, fg)
  return w
end

function widgets.create_base_text(font, alignment)
  local alignment = alignment or 'center'
  return wibox.widget {
    align  = alignment,
    valign = alignment,
    font = font,
    widget = wibox.widget.textbox
  }
end

function widgets.box(lay, widgets, space)
  local lay = lay or "horizontal" -- default horizontal
  local spacing = space or 0
  local layout = wibox.layout.fixed[lay]
  local w = wibox.widget { layout = layout, spacing = dpi(spacing) } -- init a widget
  for _, widget in ipairs(widgets) do
    w:add(widget)
  end
  return w
end

function widgets.add_margin(w, t, colour)
  local top = t.top or 0
  local bottom = t.bottom or 0
  local right = t.right or 0
  local left = t.left or 0
  local colour = colour or "#00000000"
  return wibox.widget {
    w,
    top = dpi(top), bottom = dpi(bottom),
    right = dpi(right), left = dpi(left),
    color = colour,
    widget = wibox.container.margin
  }
end

function widgets.box_with_margin(l, ws, space)
  local w = widgets.box(l, ws, space)
  return widgets.add_margin(w, { left = 5, right = 5 })
end

function widgets.box_with_bg(l, ws, space, bg)
  local w = widgets.box(l, ws, space)
  return wibox.widget {
    w,
    bg = bg,
    widget = wibox.container.background
  }
end

function widgets.bg_rounded(bg_color, border_color, w, wtype)
  return wibox.widget {
    {
      w,
      top = 3, bottom = 3, left = 10, right = 10,
      widget = wibox.container.margin
    },
    shape = gshape.rounded_rect,
    bg = bg_color,
    shape_border_color = border_color,
    shape_border_width = 2,
    widget = wibox.container.background
  }
end

function widgets.bg_border_line(bg_color, border_color, w, wtype)
  local m = widgets.margin_for_icon_or_button(w, wtype)
  local shape_line = function(cr, width, height) 
    gshape.transform(gshape.rounded_rect) : translate(0,20) (cr,width, -1, 2) 
  end
  return wibox.widget {
    {
      m,
      shape = shape_line,
      bg = bg_color,
      shape_border_color = border_color,
      shape_border_width = 2,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
  }
end

function widgets.bg(bg_color, w)
  return wibox.widget {
    {
      w,
      bg     = bg_color,
      widget = wibox.container.background
    },
    spacing = 10,
    layout  = wibox.layout.fixed.horizontal
  }
end

-- used to create an imagebox, argument image is optionnal
function widgets.imagebox(size, image)
  local w = wibox.widget {
    resize = true,
    forced_height = size,
    forced_width = size,
    widget = wibox.widget.imagebox
  }
  if image ~= nil then w.image = image end
  return w
end

function widgets.add_left_click_action(w, action, shell, class)
  local is_shell = shell or nil
  local has_class = class or nil
  w:buttons(gtable.join(
    awful.button({ }, 1, function()
      app.start(action, is_shell, has_class)
    end)
  ))
end

-- Create a slider
function widgets.make_a_slider(default_value, color)
  local color = color or M.x.primary
  local v = default_value or 15
  return wibox.widget {
    forced_height = dpi(8),
    bar_shape = gshape.rounded_rect,
    bar_height = dpi(4),
    bar_color = color .. "61", -- 38%
    handle_width = dpi(12),
    handle_color = color,
    handle_shape = gshape.circle,
    value = v,
    widget = wibox.widget.slider
  }
end

-- check popup position
function widgets.check_popup_position(wibar_position)
  local wpos = wibar_position or 'top'
  local position = 'top' -- default is top
  if wpos == 'top' then
    position = 'bottom' 
  elseif wpos == 'left' then
    position = 'right'
  elseif wpos == 'right' then
    position = 'left'
  end
  return position
end

function widgets.make_arcchart(w)
  local w = w or nil
  return wibox.widget {
    widget = wibox.container.arcchart,
    bg = M.x.primary .. "66", -- 40%
    border_color = M.x.error,
    colors = { M.x.error, M.x.on_error },
    max_value = 99,
    min_value = 0,
    paddings = 2,
    value = 1,
    --rounded_edge = true,
    forced_height = dpi(140),
    forced_width = dpi(140),
    thickness = dpi(4),
    start_angle = 4.71238898, -- 2pi*3/4
    w
  }
end

function widgets.make_progressbar(value, width, colors)
  local value = value or 10
  local width = width or 100
  local colors = colors or M.x.error
  return wibox.widget {
    max_value     = 100,
    value         = value,
    --forced_height = dpi(2),
    --forced_width  = dpi(100),
    forced_width  = width,
    paddings      = 1,
    border_width  = 1,
    border_color  = M.x.surface,
    bar_shape     = gshape.rounded_bar,
    shape         = gshape.rounded_bar,
    color         = colors,
    background_color = colors .. "66", -- 40%
    widget        = wibox.widget.progressbar
  }
end

function widgets.progressbar_layout(p, layout)
  local w
  if layout == "horizontal" then
    w = wibox.widget {
      p,
      top = 10,
      bottom = 10,
      layout = wibox.container.margin
    }
  else
    w = wibox.widget {
      {
        p,
        direction = 'east',
        layout = wibox.container.rotate,
      },
      forced_width = dpi(16),
      forced_height = dpi(55),
      top = dpi(9),
      widget = wibox.container.margin
    }
  end
  return w
end

function widgets.progressbar_margin_horiz()
  local w = wibox.container.margin()
  w.top = 4
  w.bottom = 4
  w.forced_height = 20
  return w
end

function widgets.centered(w, layout)
  local layout = layout or "horizontal"
  return wibox.widget {
    nil,
    w,
    expand = "none",
    layout = wibox.layout.align[layout]
  }
end

return widgets
