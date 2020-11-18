local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local noti = require("utils.noti")
local widget = require("util.widgets")
local helper = require("utils.helper")
local table = require('gears.table')
local icons = require("icons.default")
local font = require("util.font")
local app = require("util.app")
local ufont = require("utils.font")
local iicon = require("config.icons")
local button = require("utils.button")
local mat_text = require("utils.material.text")

-- add a little margin to avoid the popup pasted on the wibar
local padding = beautiful.widget_popup_padding or 1

-- button creation
local w = button({
  fg_icon = M.x.on_background,
  icon = ufont.icon(iicon.widget.change_theme),
  layout = "horizontal"
})

local rld = button({
  fg_icon = M.x.on_background,
  icon = ufont.icon(iicon.widget.reload),
  command = awesome.restart,
  layout = "horizontal"
})

local function make_element(name)
  local change_script = function()
    app.start(
      "~/.config/awesome/widgets/change-theme.sh --change "..name,
      true, "miniterm"
    )
    noti.info("Theme changed, Reload awesome for switch on "..name)
  end
  local w = button({
    command = change_script,
    fg_icon = M.x.on_surface,
    icon = widget.centered(widget.imagebox(90, icons[name])),
    text = ufont.button(name)
  })
  return w
end

local w_position -- the position of the popup depend of the wibar
w_position = widget.check_popup_position(beautiful.wibar_position)

local popup_widget = wibox.widget {
  {
    {
      {
        {
          nil,
          {
            ufont.h6("Change theme"),
            widget = mat_text({ lv = "high" })
          },
          rld,
          expand = "none",
          layout = wibox.layout.align.horizontal
        },
        forced_height = 48,
        widget = wibox.container.margin
      },
      {
        make_element("miami"),
        make_element("morpho"),
        make_element("worker"),
        make_element("sci"),
        make_element("lines"),
        make_element("astronaut"),
        forced_num_rows = 2,
        forced_num_cols = 3,
        spacing = 10,
        layout = wibox.layout.grid,
      },
      layout = wibox.layout.fixed.vertical
    },
    top = 8, bottom = 8,
    left = 24, right = 24,
    widget = wibox.container.margin
  },
  shape = helper.rrect(20),
  bg = M.x.on_surface .. M.e.dp01,
  widget = wibox.container.background
}

local popup = awful.popup {
  widget = popup_widget,
  visible = false, -- do not show at start
  ontop = true,
  hide_on_right_click = true,
  preferred_positions = w_position,
  offset = { y = padding, x = padding }, -- no pasted on the bar
  bg = M.x.surface
}

-- attach popup to widget
popup:bind_to_widget(w)
w:buttons(table.join(
awful.button({}, 3, function()
  popup.visible = false
end)
))

return w
