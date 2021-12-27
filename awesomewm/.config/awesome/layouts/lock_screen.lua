local awful = require("awful")
local gshape = require("gears.shape")
local wibox = require("wibox")
local naughty = require("naughty")
local helpers = require("helpers")
local widget = require("util.widgets")

local password = password or "awesome"

local lock_screen_symbol = ""
local lock_screen_fail_symbol = ""
local lock_animation_icon = wibox.widget {
    -- Set forced size to prevent flickering when the icon rotates
    forced_height = dpi(80),
    forced_width = dpi(80),
    font = M.f.h1.." 50",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox(lock_screen_symbol)
}

-- A dummy textbox needed to get user input.
-- It will not be visible anywhere.
local some_textbox = wibox.widget.textbox()

-- Create the lock screen wibox
-- Set the type to "splash" and set all "splash" windows to be blurred in your
-- compositor configuration file
lock_screen = wibox({ visible = false, ontop = true, type = "splash" })
awful.placement.maximize(lock_screen)

lock_screen.bg = M.x.surface
lock_screen.fg = M.x.on_surface

-- Lock animation
local lock_animation_widget_rotate = wibox.container.rotate()

local arc = function()
  return function(cr, width, height)
    gshape.arc(cr, width, height, dpi(5), 0, math.pi/2, true, true)
  end
end

local lock_animation_arc = wibox.widget {
  shape = arc(),
  bg = "#00000000",
  forced_width = dpi(100),
  forced_height = dpi(100),
  widget = wibox.container.background
}

local lock_animation_widget = {
  {
    lock_animation_icon,
    widget = lock_animation_arc
  },
  widget = lock_animation_widget_rotate
}

-- Lock helper functions
local characters_entered = 0
local function reset()
  characters_entered = 0
  lock_animation_icon.markup = helpers.colorize_text(lock_screen_symbol, M.x.primary)
  lock_animation_widget_rotate.direction = "north"
  lock_animation_arc.bg = "#00000000"
end

-- run once
if characters_entered == 0 then reset() end

local function fail()
  characters_entered = 0
  lock_animation_icon.markup = helpers.colorize_text(lock_screen_fail_symbol, M.x.error)
  lock_animation_widget_rotate.direction = "north"
  lock_animation_arc.bg = "#00000000"
end

local animation_colors = {
    -- Rainbow sequence =)
    M.x.primary .. "CC", -- 80%
    M.x.primary .. "E6", -- 90%
    M.x.primary .. "FF", -- 100%
    M.x.secondary .. "CC",
    M.x.secondary .. "E6",
    M.x.secondary .. "FF",
}

local animation_directions = { "north", "west", "south", "east" }

-- Function that "animates" every key press
local function key_animation(char_inserted)
  local color = M.x.on_surface
  local direction = animation_directions[(characters_entered % 4) + 1]
  if char_inserted then
    color = animation_colors[(characters_entered % 6) + 1]
    lock_animation_icon.text = lock_screen_symbol
  else
    if characters_entered == 0 then
      reset()
    else
      color = M.x.error
    end
  end

  lock_animation_icon.markup = helpers.colorize_text(lock_screen_symbol, color)
  lock_animation_arc.bg = color
  lock_animation_widget_rotate.direction = direction
end

-- Get input from user
local function grab_password()
  awful.prompt.run {
    hooks = {
      -- Custom escape behaviour: Do not cancel input with Escape
      -- Instead, this will just clear any input received so far.
      {{ }, 'Escape', function(_)
        reset()
        grab_password()
      end}
    },
    keypressed_callback  = function(mod, key, cmd)
      -- Only count single character keys (thus preventing
      -- "Shift", "Escape", etc from triggering the animation)
      if #key == 1 then
        characters_entered = characters_entered + 1
        key_animation(true)
      elseif key == "BackSpace" then
        if characters_entered > 0 then
          characters_entered = characters_entered - 1
        end
        key_animation(false)
      end

      -- Debug
      -- naughty.notify { title = 'You pressed:', text = key }
    end,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      -- Check input
      if input == password then
        -- YAY
        reset()
        lock_screen.visible = false
      else
        -- NAY
        fail()
        grab_password()
      end
    end,
    textbox = some_textbox,
  }
end

function lock_screen_show()
  lock_screen.visible = true
  grab_password()
end

-- Item placement
lock_screen:setup {
  -- Horizontal centering
  nil,
  widget.centered(lock_animation_widget, "vertical"),
  expand = "none",
  layout = wibox.layout.align.horizontal
}
