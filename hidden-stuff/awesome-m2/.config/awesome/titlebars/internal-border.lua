local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local font = require("util.font")
local titlebar = require("util.titlebar")

-- vars
local position = beautiful.titlebar_position or 'top'
local t_font = M.f.subtile_1

local function title(c)
  return wibox.widget {
    align = "center",
    font = t_font,
    widget = titlebar.is_titlebar_off(c) and wibox.widget.textbox() or awful.titlebar.widget.titlewidget(c)
  }
end

local function border(c)
  local w = wibox.widget {
    color = M.x.primary,
    bottom = 2,
    widget = wibox.container.margin
  }
  c:connect_signal("unfocus", function(c)
    w.color = M.x.secondary
  end)
  c:connect_signal("focus", function(c)
    w.color = M.x.primary
  end)
  return w
end

local function margin(c)
  local width = c.width / 3
  local w = wibox.widget {
    left = width, right = width,
    widget = wibox.container.margin
  }
  c:connect_signal("property::size", function(c)
    local width = c.width / 3
    w.left = width
    w.right = width
  end)
  return w
end

client.connect_signal("request::titlebars", function(c)

  if not titlebar.is_titlebar_off(c) then
    awful.titlebar(c, 
      { font = t_font, position = position }
    ) : setup {
      nil, -- Left
      { -- Middle
        {
          {
            title(c),
            layout  = wibox.layout.flex.horizontal
          },
          widget = border(c),
        },
        buttons = titlebar.button(c),
        widget = margin(c)
      },
      { -- Right
        titlebar.button_close(c),
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.align.horizontal
    }
  end

  -- bottom bar for ncmpcpp
  if c.class == "music_n" then
    titlebar.ncmpcpp(c, 50)
  end
end)


client.connect_signal("property::maximized", function(c)
  -- Another bottom line on rare clients
  if c.maximized and c.class ~= "music_n" then
    awful.titlebar(c, { size = 20, position = "bottom" }) : setup {
      nil,
      {
        {
          {
            {
              align = "center",
              font = t_font,
              widget = wibox.widget.textbox(),
            },
            layout  = wibox.layout.flex.horizontal
          },
          widget = border(c),
        },
        buttons = titlebar.button(c),
        widget = margin(c)
      },
      nil,
      layout = wibox.layout.align.horizontal
    }
  else
    if c.class ~= "music_n" then awful.titlebar.hide(c, "bottom") end
  end
end)
