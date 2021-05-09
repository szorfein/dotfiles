local awful = require("awful")
local gtable = require("gears.table")
local mymainmenu = require("module.menu")

local keys = {}

-- Mod keys
modkey = "Mod4"
altkey = "Mod1"
shiftkey = "Shift"
ctrlkey = "Control"

local function updateScreenPadding(nb)
  local screen = awful.screen.focused()
  local v = screen.padding.top + nb
  screen.padding = { top = v, right = v, bottom = v, left = v }
end

-- {{{ Key bindings
keys.globalkeys = gtable.join(
  --awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
  --          {description="show help", group="awesome"}),
    
  awful.key({ modkey, }, "Left", awful.tag.viewprev,
  { description = "view previous", group = "tag" }),

  awful.key({ modkey, }, "Right",  awful.tag.viewnext,
  { description = "view next", group = "tag" }),

  awful.key({ modkey, }, "Tab", awful.tag.history.restore,
  { description = "go back", group = "tag" }),

  -- {{{ Focus by direction
  awful.key({ modkey, }, "j", function()
    awful.client.focus.byidx(-1)
  end,
  { description = "focus down", group = "client" }),

  awful.key({ modkey, }, "k", function()
    awful.client.focus.byidx(1)
  end,
  { description = "focus up", group = "client" }),

  awful.key({ modkey, }, "h", function()
    awful.client.focus.bydirection("left")
  end,
  { description = "focus left", group = "client" }),

  awful.key({ modkey,           }, "l", function()
    awful.client.focus.bydirection("right")
  end,
  { description = "focus right", group = "client" }),
  -- }}} End Focus by direction

  -- {{{ Master width factor (resize)
  awful.key({ modkey, ctrlkey }, "Left", function()
    local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    local c = client.focus
    -- Floating: resize client
    if current_layout == "floating" or c.floating == true then
      c:relative_move(  0,  0, dpi(-20), 0)
    else
      awful.tag.incmwfact(-0.05)
    end
  end,
  { description = "decreased master width factor", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "Right", function()
    local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    local c = client.focus
    -- Floating: resize client
    if current_layout == "floating" or c.floating == true then
      c:relative_move(  0,  0, dpi(20), 0)
    else
      awful.tag.incmwfact(0.05)
    end
  end,
  { description = "increased master width factor", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "Down", function()
    local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    local c = client.focus
    if current_layout == "floating" or c.floating == true then
      c:relative_move(  0,  0,  0, dpi(20))
    else
      awful.client.incwfact(0.05)
    end
  end,
  { description = "increase master width factor", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "Up", function()
    local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    local c = client.focus
    if current_layout == "floating" or c.floating == true then
      c:relative_move(  0,  0,  0, dpi(-20))
    else
      awful.client.incwfact(-0.05)
    end
  end,
  { description = "decrease master width factor", group = "layout" }),
  -- }}} End Master width factor

  -- my key < + > is on < = > :(
  awful.key({ altkey, ctrlkey, shiftkey }, "=", function()
    updateScreenPadding(10) 
  end, { description = "increase padding", group = "layout" }),

  awful.key({ altkey, ctrlkey, shiftkey }, "-", function()
    updateScreenPadding(-10)
  end, { description = "decrease padding", group = "layout" }),

  awful.key({ modkey, }, "w", function() mymainmenu:show() end,
  { description = "show main menu", group = "awesome" }),

  awful.key({ modkey, }, "Escape", function() exit_screen_show() end,
  { description = "exit", group = "awesome" }),

  awful.key({ modkey }, "F4", function()
    local curr_screen = awful.screen.focused()
    curr_screen.monitor_bar.visible = not curr_screen.monitor_bar.visible
  end,
  { description = "show or toggle the monitor bar", group = "awesome" }),

  awful.key({ modkey }, "F1", function()
    local s = awful.screen.focused()
    s.start_screen.visible = not s.start_screen.visible
  end,
  { description = "show or toggle start_screen", group = "awesome" }),

  awful.key({ modkey }, "F2", function()
    local s = awful.screen.focused()
    s.nav_drawer.visible = not s.nav_drawer.visible
  end,
  { description = "show or toggle the navigation drawer", group = "awesome" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
  { description = "swap with next client by index", group = "client" }),

  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
  { description = "swap with previous client by index", group = "client" }),

  awful.key({ modkey, ctrlkey }, "j", function() awful.screen.focus_relative(1) end,
  { description = "focus the next screen", group = "screen" }),

  awful.key({ modkey, ctrlkey }, "k", function() awful.screen.focus_relative(-1) end,
  { description = "focus the previous screen", group = "screen" }),

  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
  { description = "jump to urgent client", group = "client" }),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
  { description = "open a terminal", group = "launcher" }),

  awful.key({ modkey, ctrlkey }, "r", awesome.restart,
  { description = "reload awesome", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "q", awesome.quit,
  { description = "quit awesome", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
  { description = "increase the number of master clients", group = "layout" }),

  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
  { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "h", function() awful.tag.incncol(1, nil, true) end,
  { description = "increase the number of columns", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "l", function() awful.tag.incncol(-1, nil, true) end,
  { description = "decrease the number of columns", group = "layout" }),

  awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
  { description = "select next", group = "layout" }),

  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
  { description = "select previous", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      client.focus = c
      c:raise()
    end
  end,
  { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key({ modkey }, "x", function()
    awful.prompt.run {
      prompt       = "Run Lua code: ",
      textbox      = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
  end,
  { description = "lua execute prompt", group = "awesome" }),

  -- Rofi
  --awful.key({ modkey }, "p", function() awful.spawn.with_shell("launcher") end,
  awful.key({ modkey }, "p", function()
    local s = awful.screen.focused()
    s.app_drawer.visible = not s.app_drawer.visible
    update_app_drawer()
  end,
  { description = "app launcher", group = "app launcher" }),

  -- Music Control (volume)
  awful.key({ }, "XF86AudioRaiseVolume", function()
    awful.spawn.with_shell("~/bin/volume.sh up")
  end,
  { description = "increase volume", group = "music" }),

  awful.key({ }, "XF86AudioLowerVolume", function()
    awful.spawn.with_shell("~/bin/volume.sh down")
  end,
  { description = "Lower volume", group = "music" }),

  -- Music Control (mpc)
  awful.key({ altkey, ctrlkey }, "Right", function() awful.spawn.with_shell("mpc next") end,
  { description = "music next", group = "music" }),

  awful.key({ altkey, ctrlkey }, "Left", function() awful.spawn.with_shell("mpc prev") end,
  { description = "music prev", group = "music" }),

  awful.key({ altkey, ctrlkey }, "d", function() awful.spawn.with_shell("mpc del 0") end,
  { description = "delete current playlist", group = "music" }),

  -- Brightness
  awful.key({ }, "XF86MonBrightnessUp", function()
    awful.spawn.with_shell("light -A 1")
  end,
  { description = "light mode", group = "brightness" }),

  awful.key({ }, "XF86MonBrightnessDown", function()
    awful.spawn.with_shell("light -U 1")
  end,
  { description = "dark mode", group = "brightness" }),

  awful.key({ modkey }, "r", function()
    awful.spawn.with_shell("rofi -matching fuzzy -show combi")
  end,
  { description = "rofi", group = "launcher" })
)

keys.clientkeys = gtable.join(
  -- Move floating client (relative)
  awful.key({ altkey, "Shift" }, "Down", function(c) c:relative_move( 0, 40, 0, 0 ) end),
  awful.key({ altkey, "Shift" }, "Up", function(c) c:relative_move( 0, -40, 0, 0 ) end),
  awful.key({ altkey, "Shift" }, "Left", function(c) c:relative_move( -40, 0, 0, 0 ) end),
  awful.key({ altkey, "Shift" }, "Right", function(c) c:relative_move( 40, 0, 0, 0 ) end),
  
  awful.key({ modkey, }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end,
  { description = "toggle fullscreen", group = "client" }),

  -- Set tiled layout
  awful.key({ modkey }, "t", function()
    awful.layout.set(awful.layout.suit.tile)
  end,
  { description = "set tiled layout", group = "tag" }),
      
  -- Toggle floating client
  awful.key({ modkey }, "s", function(c) 
    local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
    if not layout_is_floating then
      c.floating = not c.floating
    end
    c:raise()
  end,
  { description = "toggle floating", group = "client" }),

  awful.key({ modkey }, "z", function(c) c:kill() end,
  { description = "close", group = "client" }),

  awful.key({ modkey, ctrlkey }, "Return", function(c) c:swap(awful.client.getmaster()) end,
  { description = "move to master", group = "client" }),

  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
  { description = "move to screen", group = "client" }),

  -- awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
  --   { description = "toggle keep on top", group = "client" }),
  
  awful.key({ modkey, }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end,
  { description = "minimize", group = "client" }),

  awful.key({ modkey, }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end,
  { description = "(un)maximize", group = "client" }),

  awful.key({ modkey, ctrlkey }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end,
  { description = "(un)maximize vertically", group = "client" }),

  awful.key({ modkey, "Shift"   }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end ,
  { description = "(un)maximize horizontally", group = "client" })
  )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  keys.globalkeys = gtable.join( keys.globalkeys,

    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end,
    { description = "view tag #"..i, group = "tag"} ),

    -- Toggle tag display.
    awful.key({ modkey, ctrlkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
    { description = "toggle tag #" .. i, group = "tag"} ),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    { description = "move focused client to tag #"..i, group = "tag"} ),

    -- Toggle tag on focused client.
    awful.key({ modkey, ctrlkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
    { description = "toggle focused client on tag #" .. i, group = "tag"} )
  )
end

keys.clientbuttons = gtable.join(
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
root.keys(keys.globalkeys)
-- }}}

return keys
