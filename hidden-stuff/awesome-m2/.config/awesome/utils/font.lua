local wibox = require("wibox")

-- opacity for helper text and dark theme
-- https://material.io/design/color/dark-theme.html#ui-application

local function widget_text(font, text, align)
  local align = align or 'center'
  return wibox.widget {
    align  = align,
    valign = 'center',
    font = font,
    text = text,
    widget = wibox.widget.textbox
  }
end

local font = {}

function font.h1(text, align)
  return widget_text(M.f.h1, text, align)
end

function font.h4(text, align)
  return widget_text(M.f.h4, text, align)
end

function font.h5(text, align)
  return widget_text(M.f.h5, text, align)
end

function font.h6(text, align)
  return widget_text(M.f.h6, text, align)
end

function font.subtile_1(text, align)
  return widget_text(M.f.subtile_1, text, align)
end

function font.body_1(text, align)
  return widget_text(M.f.body_1, text, align)
end

function font.body_2(text, align)
  return widget_text(M.f.body_2, text, align)
end

function font.icon(text, align)
  return widget_text(M.f.icon, text, align)
end

function font.button(text, align)
  return widget_text(M.f.button, text, align)
end

function font.caption(text, align)
  return widget_text(M.f.caption, text, align)
end

function font.overline(text, align)
  return widget_text(M.f.overline, text, align)
end

return font
