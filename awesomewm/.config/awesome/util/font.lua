local widget = require("util.widgets")
local helpers = require("helpers")

-- opacity for helper text and dark theme
-- https://material.io/design/color/dark-theme.html#ui-application
local p = {}
p["high"] = 87
p["medium"] = 60
p["disable"] = 38

function make_widget(font, text, color, alpha)
  local alpha = alpha or 100
  local w = widget.create_base_text(font)
  w.markup = helpers.colorize_text(text, color, alpha)
  return w
end

local font = {}

function font.h1(text, fg) 
  local color = fg or M.x.on_surface
  return make_widget(M.f.font_h1, text, color)
end

function font.h4(text, fg, alpha) 
  local color = fg or M.x.on_surface
  local alpha = alpha or 100
  return make_widget(M.f.h4, text, color, alpha)
end

function font.h6(text, fg, alpha) 
  local color = fg or M.x.on_surface
  local alpha = alpha or 100
  return make_widget(M.f.h6, text, color, alpha)
end

function font.subtile_1(text, fg, alpha) 
  local color = fg or M.x.on_surface
  local alpha = alpha or M.t.disabled
  return make_widget(M.f.subtile_1, text, color, alpha)
end

function font.text_list(text, fg, alpha)
  local color = fg or M.x.on_surface
  local alpha = alpha or 70
  return make_widget(M.f.subtile_1, text, color, alpha)
end

function font.body_title(text, fg)
  local color = fg or M.x.on_surface
  return make_widget(M.f.body_1, text, color)
end

function font.body_text(text, fg, alpha)
  local color = fg or M.x.on_surface
  local alpha = alpha or 87
  local w = widget.create_base_text(M.f.body_2)
  w.markup = helpers.colorize_text(text, color, alpha)
  return w
end

local function void_text(font, text)
  local w = widget.create_base_text(font)
  w.text = text
  return w
end

function font.body_2(text)
  return void_text(M.f.body_2, text)
end

function font.button(text, fg, alpha)
  local color = fg or M.x.on_surface
  local alpha = alpha or 100
  return make_widget(M.f.button, text, color, alpha)
end

function font.button_v2(text)
  return void_text(M.f.button, text)
end

function font.caption(text, fg, alpha)
  local color = fg or M.x.on_secondary
  local alpha = alpha or 100
  return make_widget(M.f.caption, text, color, alpha)
end

function font.overline(text, fg, alpha, bg)
  local color = fg or M.x.on_secondary
  local colorline = bg or M.x.primary
  local alpha = alpha or 60
  local t = widget.create_base_text(M.f.overline)
  t.markup = helpers.colorize_text(text, color, alpha)
  local wibox = require("wibox")
  local gshape = require("gears.shape")
  local shape_line = function(cr, width, height)
    -- translate X moving to the right
    -- translate Y bring down the line (20-24 for a bottom line)
    gshape.transform(gshape.rounded_rect)
    : translate(width/3,23) (cr, width/3, -1, 2)
  end
  return wibox.widget {
    {
      t,
      bottom = 6,
      widget = wibox.container.margin
    },
    shape = shape_line,
    opacity = 0.7,
    shape_border_color = colorline,
    shape_border_width = 2,
    widget = wibox.container.background
  }
end

return font
