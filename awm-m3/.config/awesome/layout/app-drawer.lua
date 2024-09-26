local awful = require("awful")
local gtable = require("gears.table")
local wibox = require("wibox")
local keygrabber = require("awful.keygrabber")
local button = require("lib.button-elevated")
local app = require("lib.app")
local user = require('config.user')

local icon_dir = "/usr/share/icons/Papirus/64x64/apps/"
local icons = {
  web  = icon_dir .. 'brave-browser-nightly.svg',
  code = icon_dir .. 'appimagekit-emacs.svg',
  movi = icon_dir .. 'mpv.svg',
  musi = icon_dir .. 'mpd.svg',
  shel = icon_dir .. 'hotwire.svg',
  chat = icon_dir .. 'weechat.svg',
  git  = icon_dir .. 'github.svg',
  prot = icon_dir .. 'appimagekit-protonmail-desktop-unofficial.svg',
  redd = icon_dir .. 'reddit.svg',
  file = icon_dir .. 'vifm.svg',
  sync = icon_dir .. 'me.kozec.syncthingtk.svg',
  mega = icon_dir .. 'mega.svg',
  shar = icon_dir .. 'onionshare80.svg',
  term = icon_dir .. 'st.svg',
  mail = icon_dir .. 'mutt.svg',
  gimp = icon_dir .. 'gimp.svg',
  msf  = icon_dir .. 'metasploit.svg',
  tor  = icon_dir .. 'browser-tor.svg',
  arch = icon_dir .. 'distributor-logo-archlinux.svg',
  debi = icon_dir .. 'distributor-logo-debian.svg',
  void = icon_dir .. 'distributor-logo-void.svg',
  expl = icon_dir .. 'exploit-db.svg',
  priv = icon_dir .. 'cs-privacy.svg',
  yout = icon_dir .. 'youtube.svg',
  virt = icon_dir .. 'qemu.svg',
}

local ntags = 5

local box = wibox.widget {
  spacing = 18,
  forced_num_rows = 2,
  forced_num_cols = 6,
  layout = wibox.layout.grid
}
local my_apps = {}

local function app_drawer_hide()
  local s = awful.screen.focused()
  s.app_drawer.visible = false
  keygrabber.stop() -- stop the last open by default
end

local function exe_app(cmd)
  app:launch(cmd)
  app_drawer_hide()
end

local function exe_shell(cmd)
  app:shell(cmd)
  app_drawer_hide()
end

local function exe_web(link)
  app:web(link)
  app_drawer_hide()
end

my_apps[1] = {
  title = "Code",
  { name = "Xst", icon = icons.shel, key = 'x',
    exec = function() exe_app(user.terminal) end },
  { name = "Tmux", icon = icons.term, key = 't',
    exec = function() exe_shell("tmux") end },
  { name = "Emacs", icon = icons.code, key = 'e',
    exec = function() exe_app("emacs") end },
  { name = "Metasploit", icon = icons.msf, key = 'm',
    exec = function() exe_shell("msfconsole") end },
  { name = "Wireshark", icon = icons["wireshark"], key = 'w',
    exec = function() exe_app("wireshark") end }
}

my_apps[2] = {
  title = "Web",
  { name = "Brave", icon = icons.web, key = 'b',
    exec = function() exe_app(user.web) end },
  { name = "Github", icon = icons.git, key = 'g',
    exec = function() exe_web("https://github.com/szorfein") end },
  { name = "Mastodon", icon = icons.mast, key = 'm',
    exec = function() exe_web("https://mastodon.social/@szorfein") end },
  { name = "Protonmail", icon = icons.prot, key = 'p',
    exec = function() exe_web("https://protonmailrmez3lotccipshtkleegetolb73fuirgj7r4o4vfu7ozyd.onion/") end },
  { name = "Youtube", icon = icons.yout, key = 'y',
    exec = function() exe_web("https://www.youtube.com") end },
  { name = "Reddit", icon = icons.redd, key = 'r',
    exec = function() exe_web("https://www.reddit.com/u/szorfein") end },
  { name = "Exploit-db", icon = icons.expl, key = 'e',
    exec = function() exe_web("https://www.exploit-db.com/") end },
  { name = "prIvacytools", icon = icons.priv, key = 'i',
    exec = function() exe_web("https://www.privacytools.io/") end }
}

my_apps[3] = {
  title = "document",
  { name = "Libreoffice", icon = icons["writter"], key = 'v',
    exec = function() exe_app("libreoffice-writter") end },
  { name = "Weechat", icon = icons.chat, key = 'w',
    exec = function() exe_shell("weechat") end },
  { name = "Neomutt", icon = icons.mail, key = 'n',
    exec = function() exe_shell("neomutt") end },
  { name = "Signal", icon = icons["signal"], key = 's',
    exec = function() exe_app("signal") end }
}

my_apps[4] = {
  title = "music",
  { name = "Ncmpcpp", icon = icons.musi, key = 'n',
    exec = function() exe_shell("ncmpcpp") end },
  { name = "Mpv", icon = icons.movi, key = 'm',
    exec = function() exe_app("mpv ~/downloads/videos") end },
  { name = "Gimp", icon = icons.gimp, key = 'g',
    exec = function() exe_app("gimp") end },
  { name = "Wallpapers", icon = icons["images"], key = 'w',
    exec = function() app.feh("~/images", app_drawer_hide) end },
  { name = "Scrot", icon = icons["photo"], key = 's',
    exec = function() exe_app("scrot -q 100 -d 3") end }
}

my_apps[5] = {
  title = "vm",
  { name = "Archlinux", icon = icons.arch, key = 'a',
    exec = function() exe_shell("quickemu ---vm ~/.vms/archlinux.conf") end },
  { name = "Voidlinux", icon = icons.void, key = 'v',
    exec = function() exe_shell("quickemu --vm ~/.vms/void.conf") end },
  { name = "Gentoo", icon = icons.gent, key = 'g',
    exec = function() exe_shell("quickemu --vm ~/.vms/gentoo.conf") end },
  { name = "Debian", icon = icons.debi, key = 'd',
    exec = function() exe_shell("quickemu --vm ~/.vms/debian.conf") end }
}

local function key_grabber(keybinds)
  local s = awful.screen.focused()

  local grabber = keygrabber {
    keybindings = keybinds,
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

  local keybinds = {}
  box:reset()

  for _,v in ipairs(my_apps[index]) do

    local elem = {{}, v.key, function() v.exec() end }
    table.insert(keybinds, elem)

    local app_icon = button({
      image = v.icon,
      size = dpi(66),
      text = v.name,
      cmd = function() v.exec() end
    })

    box:add(app_icon)
  end

  key_grabber(keybinds)
end

-- globally - also used in the 'navigation rail'
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
