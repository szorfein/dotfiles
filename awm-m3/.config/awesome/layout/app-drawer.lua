local awful = require("awful")
local gtable = require("gears.table")
local wibox = require("wibox")
local keygrabber = require("awful.keygrabber")
local button = require("lib.button-elevated")
local app = require("lib.app")

--local icons = require("icons.app_drawer")

local ntags = 5

local box = wibox.widget { spacing = 18, layout = wibox.layout.fixed.horizontal }
local app_drawer_grabber
local my_apps = {}

local function app_drawer_hide()
  local s = awful.screen.focused()
  s.app_drawer.visible = false
  keygrabber.stop(app_drawer_grabber)
end

local function exe_app(name)
  app.start(name)
  app_drawer_hide()
end

local function exe_shell(cmd, class)
  local have_class = class or nil
  app.start(cmd, true, have_class)
  app_drawer_hide()
end

local function exe_web(link)
  app.start(web_browser .. " " .. link)
  app_drawer_hide()
end

local papyrus = "/usr/share/icons/Papirus/64x64/apps"
local emacs_icon = papyrus .. "/emacs.svg"

-- About the code  (bold), you can use <u></u> (underline) or even
-- <i></i> (italic) if you prefer
my_apps[1] = {
  title = "Code",
  { name = "Xst", icon = icons["st"], exec = function() exe_app(terminal) end },
  { name = "Tmux", icon = icons["tilix"], exec = function() exe_shell("tmux") end },
  { name = "Emacs", icon = emacs_icon, exec = function() exe_app("emacs") end  },
  keybindings = {
    { {}, 'x', function() exe_app(terminal) end },
    { {}, 't', function() exe_shell("tmux") end },
    { {}, 'e', function() exe_app("emacs") end },
  },
}

my_apps[2] = {
  title = "Web",
  { name = "Brave", icon = icons["brave"], exec = function()
    exe_app(web_browser)
  end },
  { name = "Github", icon = icons["github"], exec = function()
    exe_web("https://github.com/szorfein")
  end },
  { name = "Mastodon", icon = icons["mastodon"], exec = function()
    exe_web("https://mastodon.social/@szorfein")
  end },
  { name = "Protonmail", icon = icons["protonmail"], exec = function()
    exe_web("https://protonmailrmez3lotccipshtkleegetolb73fuirgj7r4o4vfu7ozyd.onion/")
  end },
  { name = "Youtube", icon = icons["youtube"], exec = function()
    exe_web("https://www.youtube.com")
  end },
  { name = "Reddit", icon = icons["reddit"], exec = function()
    exe_web("https://www.reddit.com/u/szorfein")
  end },
  { name = "Exploit-db", icon = icons["exploit-db"], exec = function()
    exe_web("https://www.exploit-db.com/")
  end },
  { name = "prIvacytools", icon = icons["privacy"], exec = function()
    exe_web("https://www.privacytools.io/")
  end },
  keybindings = {
    { {}, 'b', function() exe_app(web_browser) end },
    { {}, 'g', function() exe_web("https://github.com/szorfein") end },
    { {}, 'm', function() exe_web("https://mastodon.social/@szorfein") end },
    { {}, 'p', function() exe_web("https://protonmailrmez3lotccipshtkleegetolb73fuirgj7r4o4vfu7ozyd.onion/") end },
    { {}, 'y', function() exe_web("https://www.youtube.com") end },
    { {}, 'r', function() exe_web("https://www.reddit.com/u/szorfein") end },
    { {}, 'e', function() exe_web("https://www.exploit-db.com/") end },
    { {}, 'i', function() exe_web("https://www.privacytools.io/") end }
  },
}

my_apps[3] = {
  title = "web-dev",
  { name = "Ruby", icon = icons["ruby"], exec = function() exe_shell("nnn ~/Downloads/Book/RUBY") end },
  { name = "Swift", icon = icons["swift"], exec = function() exe_shell("nnn ~/Downloads/Book/SWIFT") end },
  { name = "seLinux", icon = icons["selinux"], exec = function() exe_shell("nnn ~/Downloads/Book/LINUX") end },
  keybindings = {
    { {}, 'r', function() exe_shell("nnn ~/Downloads/Book/RUBY") end },
    { {}, 's', function() exe_shell("nnn ~/Downloads/Book/SWIFT") end },
    { {}, 'l', function() exe_shell("nnn ~/Downloads/Book/LINUX") end },
  },
}

my_apps[4] = {
  title = "hack",
  { name = "Metasploit", icon = icons["metasploit"], exec = function() exe_shell("msfconsole") end },
  { name = "Hydra", icon = icons["hydra"], exec = function() exe_shell("hydra") end },
  { name = "wpScan", icon = icons["wpscan"], exec = function() exe_shell("wpscan") end },
  { name = "Wireshark", icon = icons["wireshark"], exec = function() exe_app("wireshark") end },
  { name = "Reaver", icon = icons["reaver"], exec = function() exe_shell("reaver") end },
  { name = "niKto", icon = icons["nikto"], exec = function() exe_shell("nikto") end },
  keybindings = {
    { {}, 'm', function() exe_shell("msfconsole") end },
    { {}, 'h', function() exe_shell("hydra") end },
    { {}, 's', function() exe_shell("wpscan") end },
    { {}, 'w', function() exe_app("wireshark") end },
    { {}, 'r', function() exe_shell("reaver") end },
    { {}, 'k', function() exe_shell("nikto") end },
  }
}

my_apps[5] = {
  title = "music",
  { name = "Ncmpcpp", icon = icons["mpd"], exec = function() exe_shell("ncmpcpp") end },
  { name = "Cava", icon = icons["terminal"], exec = function() exe_shell("cava") end },
  { name = "Mpv", icon = icons["mpv"], exec = function() exe_shell("mpv ~/videos", "miniterm") end },
  keybindings = {
    { {}, 'n', function() exe_shell("ncmpcpp") end },
    { {}, 'c', function() exe_shell("cava") end },
    { {}, 'm', function() exe_shell("mpv ~/videos", "miniterm") end },
  },
}

my_apps[6] = {
  title = "chat",
  { name = "Weechat", icon = icons["irc-chat"], exec = function() exe_shell("weechat") end },
  { name = "Neomutt", icon = icons["mail"], exec = function() exe_shell("neomutt") end },
  { name = "Signal", icon = icons["signal"], exec = function() exe_app("signal") end },
  keybindings = {
    { {}, 'w', function() exe_shell("weechat") end },
    { {}, 'n', function() exe_shell("neomutt") end },
    { {}, 's', function() exe_app("signal") end },
  },
}

my_apps[7] = {
  title = "document",
  { name = "Libreoffice", icon = icons["writter"], exec = function() exe_app("libreoffice-writter") end },
  keybindings = {
    { {}, 'v', function() exe_app("libreoffice") end },
  },
}

my_apps[8] = {
  title = "image",
  { name = "Gimp", icon = icons["gimp"], exec = function() exe_app("gimp") end },
  { name = "Wallpapers", icon = icons["images"], exec = function() app.feh("~/images", app_drawer_hide) end },
  { name = "Imagemagick", icon = icons["imagemagick"], exec = function() exe_shell("imagemagick") end },
  { name = "Scrot", icon = icons["photo"], exec = function() exe_app("scrot -q 100 -d 3") end },
  keybindings = {
    { {}, 'g', function() exe_app("gimp") end },
    { {}, 'w', function() app.feh("~/images", app_drawer_hide) end },
    { {}, 'i', function() exe_shell("imagemagick") end },
    { {}, 's', function() exe_app("scrot -q 100 -d 3") end },
  },
}

my_apps[5] = {
  title = "vm",
  { name = "Archlinux", icon = icons["qemu"], exec = function() exe_shell("quickemu") end },
  { name = "Voidlinux", icon = icons["qemu"], exec = function() exe_shell("quickemu") end },
  { name = "Gentoo", icon = icons["qemu"], exec = function() exe_shell("quickemu") end },
  { name = "Debian", icon = icons["qemu"], exec = function() exe_shell("quickemu") end },
  keybindings = {
    { {}, 'a', function() exe_shell("quickemu --vm ~/.vms/archlinux.conf") end },
    { {}, 'v', function() exe_app("quickemu --vm ~/.vms/voidlinux.conf") end },
    { {}, 'g', function() exe_app("quickemu --vm ~/.vms/gentoo.conf") end },
    { {}, 'd', function() exe_app("quickemu --vm ~/.vms/debian.conf") end }
  },
}

my_apps[10] = {
  title = "games",
  { name = "Lutris", icon = icons["lutris"], exec = function() exe_app("lutris") end },
  { name = "Steam", icon = icons["steam"], exec = function() exe_app("Steam") end },
  { name = "Dontstarve", icon = icons["dontstarve"], exec = function() exe_app("lutris") end },
  { name = "Warzone2100", icon = icons["warzone2100"], exec = function() exe_app("warzone2100") end },
  keybindings = {
    { {}, 'l', function() exe_app("lutris") end },
    { {}, 's', function() exe_app("Steam") end },
    { {}, 'd', function() exe_app("lutris") end },
    { {}, 'w', function() exe_app("warzone2100") end },
  },
}

local function key_grabber(app_tag)
  local s = awful.screen.focused()

  local grabber = keygrabber {
      keybindings = app_tag.keybindings,
      stop_key = "Escape",
      stop_callback = function() app_drawer_hide() end,
  }

  if grabber.is_running and s.app_drawer.visible == false then
    grabber:stop()
  elseif s.app_drawer.visible == false then
    grabber:stop()
  else
    grabber:start()
  end
end

local function gen_menu(index)
  if not my_apps[index] then return end

  box:reset()
  for _,v in ipairs(my_apps[index]) do

    local app_icon = button({
      icon = v.icon,
      size = dpi(48),
      text = v.name,
      cmd = function() v.exec() end
    })

    box:add(app_icon)
  end

  key_grabber(my_apps[index])
end

function update_app_drawer(desired_tag)
  local s = awful.screen.focused()
  local d = tonumber(desired_tag) or nil
  local curr_tag = s.selected_tag
  if d ~= nil then
    gen_menu(d)
  elseif curr_tag ~= nil then
    gen_menu(curr_tag.index)
  else -- fallback to find the right curr_tag
    for i = 1, ntags do
      if curr_tag == s.tags[i] then
        gen_menu(i)
        break
      end
    end
  end
end

local myapps = class()

function myapps:init(screen)
  self.app_drawer = require('lib.dialog')({
    name = 'app_drawer',
    s = screen,
    widget = box
  })

  self.app_drawer:just_centered()

  self.app_drawer:set_buttons(gtable.join(
    -- Middle click - Hide app_drawer
    awful.button({}, 2, function()
      app_drawer_hide()
    end),
    -- Right click - Hide app_drawer
    awful.button({}, 3, function()
      app_drawer_hide()
    end)
  ))
end

return myapps
