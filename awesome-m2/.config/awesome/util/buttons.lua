local gtable = require("gears.table")
local abutton = require("awful.button")
local widget = require("util.widgets")
local helpers = require("helpers")
local font = require("util.font")
local btext = require("util.mat-button")

local buttons = {}

function buttons.text_list(text, cmd, color)
  local color = color or "on_surface"
  local w = btext({
    font_text = M.f.subtile_1,
    text = text,
    fg_text = color,
    overlay = color,
    rrect = 2,
    command = cmd,
    wtext = font.text_list(text, M.x[color])
  })
  return w
end

return buttons
