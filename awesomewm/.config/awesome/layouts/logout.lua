local wibox = require("wibox")
local awful = require("awful")
local keygrabber = require("awful.keygrabber")
local button = require("utils.button")
local modal = require("utils.modal")
local helper = require("utils.helper")
local font = require("utils.font")
local icons = require("config.icons")

-- keylogger
local exit_screen_grabber

function exit_screen_hide()
  local s = awful.screen.focused()
  keygrabber.stop(exit_screen_grabber)

  s.exit_screen.visible = false
end

local function poweroff_command()
  awful.spawn("sudo systemctl poweroff")
end

-- button poweroff
local poweroff = button({
  fg_icon = M.x.error,
  icon = font.h1(icons.widget.poweroff),
  text = font.button("Poweroff"),
  width = 110,
  spacing = 8,
  command = poweroff_command,
})

local function reboot_command()
  awful.spawn("sudo systemctl reboot")
end

-- button reboot
local reboot = button({
  fg_icon = M.x.error_variant_1,
  icon = font.h1(icons.widget.reboot),
  text = font.button("Reboot"),
  width = 110,
  spacing = 8,
  command = reboot_command,
})

local function exit_command()
  awesome.quit()
end

-- button exit
local exit = button({
  fg_icon = M.x.primary,
  icon = font.h1(icons.widget.exit),
  text = font.button("Exit"),
  width = 110,
  spacing = 8,
  command = exit_command,
})

local function lock_command()
    exit_screen_hide()
    lock_screen_show()
end

-- button lock
local lock = button({
  fg_icon = M.x.secondary,
  icon = font.h1(icons.layout.lock),
  text = font.button("Lock"),
  width = 110,
  spacing = 8,
  command = lock_command,
})

local exit_root = class()

function exit_root:init(s)

  -- exit_screen creation
  s.exit_screen = modal:init()

  function exit_screen_show()
    local grabber = keygrabber {
      keybindings = {
        { {}, 'p', function() poweroff_command() end },
        { {}, 'r', function() reboot_command() end },
        { {}, 'e', function() exit_command() end },
        { {}, 'l', function() lock_command() end },
        { {}, 'q', function() exit_screen_hide() end },
      },
      stop_key = "Escape",
      stop_callback = function() exit_screen_hide() end,
    }

    if grabber.is_running and s.exit_screen.visible == false then
      grabber:stop()
    elseif s.exit_screen.visible == false then
      grabber:stop()
    end

    grabber:start()
    s.exit_screen.visible = true
  end

  -- buttons
  modal:add_buttons(exit_screen_hide)

  local w = wibox.widget {
    {
      {
        { nil, poweroff, nil, expand = "none", layout = wibox.layout.align.vertical },
        { nil, reboot, nil, expand = "none", layout = wibox.layout.align.vertical },
        { nil, exit, nil, expand = "none", layout = wibox.layout.align.vertical },
        { nil, lock, nil, expand = "none", layout = wibox.layout.align.vertical },
        spacing = 12,
        layout = wibox.layout.fixed.horizontal
      },
      margins = 20,
      widget = wibox.container.margin
    },
    shape = helper.rrect(20),
    bg = M.x.surface,
    widget = wibox.container.background
  }

  modal:run_center(w)
end

return exit_root
