local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

local helpers = {}

-- Create rounded rectangle shape
helpers.rrect = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
    --gears.shape.octogon(cr, width, height, radius)
    --gears.shape.rounded_bar(cr, width, height)
  end
end

-- Create rectangle shape
helpers.rect = function()
  return function(cr, width, height)
    gears.shape.rectangle(cr, width, height)
  end
end

function helpers.create_titlebar(c, titlebar_buttons, titlebar_position, titlebar_size)
  awful.titlebar(c, {font = beautiful.titlebar_font, position = titlebar_position, size = titlebar_size}) : setup {
    { 
      buttons = titlebar_buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { 
      buttons = titlebar_buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    {
      buttons = titlebar_buttons,
      layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.align.horizontal
  }
end

function helpers.colorize_text(txt, fg, alpha)
  local txt = tostring(txt) or tostring(nil)
  local alpha = alpha or 100
  --local naughty = require("naughty")
  --naughty.notify({ text = "err "..tostring(txt) .. " and "..tostring(fg) })
  return '<span foreground="'..fg..'" alpha="'..alpha..'%">'..txt..'</span>'
end

function helpers.ret_content(path)
  local f = io.open(path, 'r')
  if f == nil then return end
  local s = f:read("*a")
  f:close()
  return s
end

local function in_percent(size, coord)
  local value = 0
  -- if x , use width screen
  if coord == 'x' then
    value = screen_width / 100 * size
  -- if y, use height screen
  else
    value = screen_height / 100 * size
  end
  return value
end

-- Create the gravity system like subtlewm
function helpers.like_subtle(gravities) -- args: x, y, width, height
  local x = in_percent(gravities[1], 'x')
  local y = in_percent(gravities[2], 'y')
  local width = in_percent(gravities[3], 'x')
  local height = in_percent(gravities[4], 'y')
  return  { floating = true, width = width, height = height, x = x, y = y }
end

return helpers
