local awful = require("awful")
local wibox = require("wibox")
local shape = require("gears.shape")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

local helper = {}

-- Create rounded rectangle shape
helper.rrect = function(radius)
  return function(cr, width, height)
    shape.rounded_rect(cr, width, height, radius)
  end
end

-- Create rectangle shape
helper.rect = function()
  return function(cr, width, height)
    shape.rectangle(cr, width, height)
  end
end

function helper.colorize_text(txt, fg, alpha)
  local txt = tostring(txt) or tostring(nil)
  local alpha = alpha or 100
  --local naughty = require("naughty")
  --naughty.notify({ text = "err "..tostring(txt) .. " and "..tostring(fg) })
  return '<span foreground="'..fg..'" alpha="'..alpha..'%">'..txt..'</span>'
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
function helper.like_subtle(gravities) -- args: x, y, width, height
  local x = in_percent(gravities[1], 'x')
  local y = in_percent(gravities[2], 'y')
  local width = in_percent(gravities[3], 'x')
  local height = in_percent(gravities[4], 'y')
  return  { floating = true, width = width, height = height, x = x, y = y }
end

return helper
