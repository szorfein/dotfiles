local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local font = require("util.font")

-- beautiful vars
local date_icon = beautiful.widget_date_icon or ""
local fg = beautiful.widget_date_fg or M.x.on_background
local bg = beautiful.widget_date_bg or M.x.background
local l = beautiful.widget_date_layout or 'horizontal'
local spacing = beautiful.widget_spacing or 1

-- widget creation
local icon = font.button(date_icon, fg, M.t.medium)
local text = font.button("")
date_widget = widget.box_with_margin(l, { icon, text }, spacing)

local date_script = [[
  bash -c "
  date  +'%a %d %b'
  "]]

awful.widget.watch(date_script, 60, function(widget, stdout)
  local date = stdout:match('%a+%s?%d+%s?%a+')
  icon.markup = helpers.colorize_text(date_icon, fg, M.t.medium)
  text.markup = helpers.colorize_text(date, fg, M.t.medium)
end)
