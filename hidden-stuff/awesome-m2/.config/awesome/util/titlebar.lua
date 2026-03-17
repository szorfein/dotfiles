local awful = require("awful")
local gtable = require("gears.table")
local shape = require("gears.shape")
local wibox = require("wibox")
local button = require("utils.button")
local font = require("utils.font")
local beautiful = require("beautiful")
local helper = require("utils.helper")

local ncmpcpp = require("widgets.mpc")({ 
  mode = "titlebar"
})

local titlebar = {}

function titlebar.button(c)
  local buttons = gtable.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )
  return buttons
end

function titlebar.is_titlebar_off(c)
  local client_off = { 'Brave-browser', 'Lutris', 'music_n' } -- from the rc.lua
    for _,v in pairs(client_off) do
      if v == c.class then
        return true 
      end
    end
  return false
end

function titlebar.ncmpcpp(c, size)
  local size = size or 50
  awful.titlebar(c, {
    position = "bottom", size = dpi(size)
  }) : setup {
    nil,
    ncmpcpp,
    expand = "none",
    layout = wibox.layout.align.horizontal
  }
end

local function gen_button(c, icon, fg, cmd)
  return button({
    fg_icon = fg, icon = font.button(icon), command = function()
      cmd(c)
    end
  })
end

function titlebar.button_close(c)
  local close = function() c:kill() end
  return gen_button(c, '', M.x.error, close)
end

function titlebar.button_maximize(c)
  local maximize = function()
    c.maximized = not c.maximized
    c:raise()
  end
  return gen_button(c, '', M.x.primary, maximize)
end

function titlebar.button_minimize(c)
  local minimize = function()
    c.minimized = true
  end
  return gen_button(c, '', M.x.secondary, minimize)
end

function titlebar.title(c)
  local w
  if beautiful.titlebar_title_enabled then
    w = awful.titlebar.widget.titlewidget(c)
    w.font = M.f.subtile_2
    w:set_align("center")
  else
    w = wibox.widget.textbox("")
  end
  return w
end

function titlebar.enable_rounding()
  -- Apply rounded corners to clients if needed
  if beautiful.border_radius and beautiful.border_radius > 0 then
    client.connect_signal("manage", function (c, startup)
      if not c.fullscreen and not c.maximized then
        c.shape = helper.rrect(beautiful.border_radius)
      end
    end)

    -- Fullscreen and maximized clients should not have rounded corners
    local function no_round_corners (c)
      if c.fullscreen or c.maximized then
        c.shape = shape.rectangle
      else
        c.shape = helper.rrect(beautiful.border_radius)
      end
    end

    client.connect_signal("property::fullscreen", no_round_corners)
    client.connect_signal("property::maximized", no_round_corners)

    beautiful.snap_shape = helper.rrect(beautiful.border_radius * 2)
  else
    beautiful.snap_shape = shape.rectangle
  end
end

return titlebar
