local awful = require('awful')
local wibox = require('wibox')
local table = require('gears.table')
local button = require('lib.button-elevated')
local app = require('lib.app')

local name = 'logout'
local logout = class()

function logout:init(s)
  self.dialog = require('lib.dialog')({
    screen = s,
    name = name })

  self.dialog:centered(
    'Logout',
    self:widget()
  )

  self.buttons = table.join(
    awful.button({}, 3, function() logout_hide() end)
  )

  self.dialog:set_buttons(self.buttons)
end

function logout:widget()
  return wibox.widget {
    button({
      icon = '󰤆',
      size = dpi(55),
      color = md.sys.color.error,
      cmd = function()
        awful.spawn.with_shell('sudo poweroff')
      end
    }),
    button({
      icon = '󰈆',
      size = dpi(55),
      color = md.sys.color.secondary,
      cmd = awesome.quit
    }),
    button({
      icon = '󰌾',
      cmd = function()
        logout_hide()
        app:lock()
      end,
      size = dpi(55),
      color = md.sys.color.tertiary
    }),
    button({
      icon = '󰜉',
      size = dpi(55),
      cmd = awesome.restart,
    }),
    spacing = dpi(16),
    layout = wibox.layout.fixed.horizontal
  }
end

-- add a keygrabber
local logout_grabber

local keybinds = {
  ['escape'] = function() logout_hide() end,
  ['q'] = function() logout_hide() end,
  ['e'] = awesome.quit,
  ['p'] = function() awful.spawn_with_shell('sudo poweroff') end,
  ['r'] = awesome.restart,
  ['l'] = function()
    logout_hide()
    app:lock()
  end
}

-- add global functions
function logout_hide()
  local s = awful.screen.focused()

  awful.keygrabber.stop(logout_grabber)

  if s[name] then
    s[name].visible = false
  end
end

function logout_display()
  local s = awful.screen.focused()

  logout_grabber = awful.keygrabber.run(function(_, key, event)
    -- Ignore case
    key = key:lower()

    if event == "release" then return end

    if keybinds[key] then
      keybinds[key]()
    end
  end)

  if s[name] then
    s[name].visible = true
  end
end

return logout
