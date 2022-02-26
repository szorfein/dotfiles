-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Function to create object in lua - used globally
local function new(self, ...)
  local instance = setmetatable({}, { __index = self })
  return instance:init(...) or instance
end

-- Function to create object in lua - used globally
function class(base)
  return setmetatable({ new = new }, { __call = new, __index = base })
end

-- Globally
dpi = beautiful.xresources.apply_dpi
md = require("material") -- md for Material Design

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init( os.getenv('HOME') .. "/.config/awesome/theme.lua" )

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

local helpers = require('lib.helpers')
local text_button = require('lib.mat.text-button')

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local names = { "󰆍", "󰖟", "󰈙", "󰎁", "󰆧" }
local l = awful.layout.suit
local layouts = { l.tile, l.tile, l.floating, l.floating, l.floating,
  l.floating, l.floating, l.floating, l.floating }

awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = {
  { "awesome", myawesomemenu, beautiful.awesome_icon },
  { "open terminal", terminal }}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock('%H:%M ')

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(names, s, layouts)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc( 1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc( 1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  s.mytaglist = require('mod.taglist')({ screen = s })

  -- Create a tasklist widget
  s.mytasklist = require('mod.tasklist')({ screen = s })

  s.rail = require('layout.navigation-rail')({
    screen = s,
    menubar = menubar,
    taglist = s.mytaglist })

  local dashboard = text_button({
    content = '舘',
    fg = md.sys.color.on_surface,
    cmd = function()
      s.dashboard.visible = true
    end
  })

  -- Create the wibox
  s.mywibox = awful.wibar({ position = 'top', screen = s, height = dpi(40) })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mypromptbox,
    },
    {
      s.mytasklist, -- Middle widget
      bg = md.sys.color.surface,
      widget = wibox.container.background
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      dashboard,
      mykeyboardlayout,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }

  -- all other layouts
  require('layout')(s)
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    { description="show help", group="awesome" }),
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  awful.key({ modkey,           }, "j", function()
    awful.client.focus.byidx( 1)
  end,
  { description = "focus next by index", group = "client" }),
  awful.key({ modkey,           }, "k", function()
    awful.client.focus.byidx(-1)
  end,
  { description = "focus previous by index", group = "client" }),
  awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
  { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(  1) end,
  { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1) end,
  { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end,
  { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
  { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
  { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey,           }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end,
  { description = "go back", group = "client" }),

  -- Standard program
  awful.key({ modkey,           }, "Return", function() awful.spawn(terminal) end,
  { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
  { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit,
  { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey,           }, "l", function() awful.tag.incmwfact(0.05) end,
  { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey,           }, "h", function() awful.tag.incmwfact(-0.05) end,
  { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift"   }, "h", function() awful.tag.incnmaster(1, nil, true) end,
  { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift"   }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
  { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
  { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
  { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey,           }, "space", function() awful.layout.inc( 1) end,
  { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(-1) end,
  { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal(
      "request::activate", "key.unminimize", { raise = true }
      )
    end
  end,
  { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key({ modkey }, "r", function()
    awful.screen.focused().mypromptbox:run()
  end,
  { description = "run prompt", group = "launcher" }),

  awful.key({ modkey }, "x", function()
    awful.prompt.run {
      prompt       = "Run Lua code: ",
      textbox      = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
  end,
  { description = "lua execute prompt", group = "awesome" }),
  -- Menubar
  awful.key({ modkey }, "p", function() menubar.show() end,
  { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
  awful.key({ modkey,           }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end,
  { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift"   }, "c", function(c) c:kill() end,
  { description = "close", group = "client" }),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
  { description = "toggle floating", group = "client" }),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end,
  { description = "move to master", group = "client" }),
  awful.key({ modkey,           }, "o", function(c) c:move_to_screen() end,
  { description = "move to screen", group = "client" }),
  awful.key({ modkey,           }, "t", function (c) c.ontop = not c.ontop end,
  { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey,           }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end ,
  { description = "minimize", group = "client" }),
  awful.key({ modkey,           }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end ,
  { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end,
  { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift"   }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end,
  { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntag = 5
for i = 1, ntag do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end,
    { description = "view tag #"..i, group = "tag" }),

    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
    { description = "toggle tag #" .. i, group = "tag" }),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    { description = "move focused client to tag #"..i, group = "tag" }),

    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
    { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  { rule = { class = "Firefox" },
    properties = { screen = 1, tag = "2" }
  },
}
-- }}}

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

  naughty.notify({ preset = naughty.config.presets.debug,
  title = "client " .. tostring(c.name),
  text = tostring(c.name) })

  naughty.notify({ preset = naughty.config.presets.debug,
  title = "client " .. tostring(#client.get()),
  text = tostring(#client.get()) })

  if not c.fullscreen and not c.maximized then
    c.shape = helpers.rrect(dpi(12))
  end

  -- if a client appear on first tag, hide the dashboard
  local t = c.first_tag
  if t.name == names[1] then
    local sf = awful.screen.focused()
    sf.dashboard.visible = false
  end
end)

local function no_round_corners(c)
  if c.fullscreen or c.maximized then
    c.shape = gears.shape.rectangle
  else
    c.shape = helpers.rrect(dpi(12))
  end
end

client.connect_signal("property::fullscreen", no_round_corners)
client.connect_signal("property::maximized", no_round_corners)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  local close_button = text_button({
    content = '',
    fg = md.sys.color.error,
    cmd = function() c:kill() end
  })

  awful.titlebar(c) : setup {
    {
      { -- Left
        nil,
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
        nil,
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        close_button,
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    },
    bg = md.sys.color.surface,
    widget = wibox.container.background
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

-- Start dashboard if no client exist
sf = awful.screen.focused()
sf.dashboard.visible = true