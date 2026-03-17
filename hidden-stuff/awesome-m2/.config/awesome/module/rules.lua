local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("config.keys") -- TODO: remove soon
local helpers = require("helpers")

-- Rules
awful.rules.rules = {

  -- All clients will match this rule.
  { 
    rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys, -- TODO: remove soon
      buttons = keys.clientbuttons, -- TODO: remove soon
      screen = awful.screen.preferred,
      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients
  { 
    rule_any = {
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
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "pinentry",
        "veromix",
        "xtightvncviewer"
        --"feh"
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
      },
      type = {
        "dialog",
      },
    }, properties = { floating = true }
  },

  -- On top
  {
    rule_any = {
      class = {
        "Rofi",
        "mpv",
      },
    },
    properties = {
      ontop = true,
    },
  },

  -- Add titlebars to normal clients and dialogs
  { 
    rule_any = { 
      type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },

  -- Titlebars OFF
  { 
    rule_any = {
      class = {
        "Brave-browser",
        "Lutris"
      },
    }, properties = { },
    callback = function(c)
      awful.titlebar.hide(c,"top")
      awful.titlebar.hide(c,"bottom")
      awful.titlebar.hide(c,"left")
      awful.titlebar.hide(c,"right")
    end
  },

  -- Fullscreen
  {
    rule_any = {
      class = {
        "baldur.exe",
      },
    }, properties = { fullscreen = true }
  },

  { 
    rule = { class = "music_n" },
    properties = helpers.like_subtle(beautiful.gravity_ncmpcpp or {4, 14, 30, 49}) 
  },

  { 
    rule = { class = "music_c" },
    properties = helpers.like_subtle(beautiful.gravity_cava or { 4, 67, 30, 20 }) 
  },

  {
    rule = { class = "music_t" },
    properties = helpers.like_subtle(beautiful.gravity_music_term or { 40, 67, 30, 20 })
  },

  {
    rule = { class = "chat" },
    properties = helpers.like_subtle(beautiful.gravity_chat or { 6, 13, 40, 66 })
  },

  {
    rule = { class = "mail" },
    properties = helpers.like_subtle(beautiful.gravity_mail or { 53, 13, 40, 66 })
  },

  { 
    rule_any = {
      class = {
        "miniterm", -- i use this when i need to enter password with sudo
      },
    }, properties = helpers.like_subtle({33, 33, 33, 33}) -- center33
  },

  -- Centered
  {
    rule_any = {
      class = {
        "feh",
        "Sxiv",
        "mpv",
        "shellweb", -- rss popup
      },
      name = {
        "Save File",
        "Page Unresponsive",
        "Pages Unresponsive",
      },
    }, properties = helpers.like_subtle({25, 25, 50, 50}), -- center66
    callback = function(c)
      awful.placement.centered(c,{ honor_padding = true, honor_workarea = true })
    end
  },

  -- Additional rules for floating apps
  {
    rule_any = {
      class = {
        "feh",
      },
    },
    properties = {
      skip_decoration = true,
      hide_titlebars = true,
      ontop = true,
      placement = awful.placement.centered
    },
  },

  -- Maximized
  {
    rule_any = {
      class = {
        "Zathura",
        "VirtualBox Machine",
      },
    }, properties = { maximized = true } 
  },

  -- Apps by screen(s)/tag(s)
  {
    rule_any = {
      class = {
        "Brave-browser",
        "Firefox",
        "Tor Browser"
      }
    },
    properties = { tag = screen[1].tags[2] } 
  },

  { 
    rule = { class = "music*" },
    properties = { tag = screen[1].tags[5] }
  },

  {
    rule = { class = "Gimp" },
    properties = { tag = screen[1].tags[8] }
  },

  {
    rule = { class = "mail" },
    properties = { tag = screen[1].tags[6] }
  },

  {
    rule = { class = "chat" },
    properties = { tag = screen[1].tags[6] }
  },

  {
    rule_any = {
      class = {
        "VirtualBox",
        "VirtualBox Manager"
      },
    }, properties = { tag = screen[1].tags[9] }
  },

  { 
    rule_any = {
      class = {
        "baldur.exe",
        "Wine"
      },
    }, properties = { tag = screen[1].tags[9] }
  }
}
