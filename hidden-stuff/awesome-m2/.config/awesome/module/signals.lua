local beautiful = require("beautiful")
local awful = require("awful")
local helpers = require("helpers")
local gears = require("gears")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enforce floating mode on layout.suit.floating and enable floating on layout.tile
client.connect_signal("property::floating", function(c)
  -- on floating
  local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
  if layout_is_floating then
    c.floating = true
    c.shape = helpers.rrect(beautiful.border_radius)
  end
  -- on tile
  local layout_is_tile = (awful.layout.get(mouse.screen) == awful.layout.suit.tile)
  if layout_is_tile and c.floating then
    c.shape = helpers.rrect(beautiful.border_radius)
  else
    c.shape = gears.shape.rectangle
  end
end)

-- Rounded Corner only on floating client
if beautiful.border_radius ~= 0 then
  client.connect_signal("manage", function (c, startup)
    if not c.fullscreen and not c.maximized and c.floating then
      c.shape = helpers.rrect(beautiful.border_radius)
    end
  end)

  -- Fullscreen & maximised clients should not have rounded corners
  local function no_round_corners(c)
    if c.fullscreen or c.maximized or not c.floating then
      c.shape = gears.shape.rectangle
    else
      c.shape = helpers.rrect(beautiful.border_radius)
    end
  end

  client.connect_signal("property::fullscreen", no_round_corners)
  client.connect_signal("property::maximized", no_round_corners)
end

-- No borders if only one tiled client
screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    if #s.tiled_clients == 1 and c.floating == false and c.first_tag.layout.name ~= "floating" then
      c.border_width = 0
    elseif #s.tiled_clients > 1 or c.first_tag.layout.name == "floating" then
      c.border_width = beautiful.border_width
    end
  end
end)

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
tag.connect_signal('property::layout', function(t)
  for k, c in ipairs(t:clients()) do
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
      -- Geometry x = 0 and y = 0 most probably means that the
      -- clients have been spawned in a non floating layout, and thus
      -- they don't have their floating_geometry set properly.
      -- If that is the case, don't change their geometry
      local cgeo = awful.client.property.get(c, 'floating_geometry')
      if cgeo ~= nil then
        if not (cgeo.x == 0 and cgeo.y == 0) then
          c:geometry(awful.client.property.get(c, 'floating_geometry'))
        end
      end
      --c:geometry(awful.client.property.get(c, 'floating_geometry'))
    end
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

if beautiful.border_width > 0 then
  local focus = beautiful.border_focus or M.x.error ..M.e.dp01
  local unfocus = beautiful.border_normal or M.x.background
  client.connect_signal("focus", function(c) c.border_color = focus end)
  client.connect_signal("unfocus", function(c) c.border_color = unfocus end)
end
