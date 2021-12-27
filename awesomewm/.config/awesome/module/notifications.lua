local noti = require("utils.noti")
local naughty = require("naughty")

-- timeout
naughty.config.defaults.timeout = 10
naughty.config.presets.low.timeout = 4
naughty.config.presets.critical.timeout = 0 -- click to disable

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  noti.critical(awesome.startup_errors)
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
  -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    noti.critical(err)
    in_error = false
  end)
end

-- signal, TODO need awesome-git as dependencies to enable the signal !!
-- i wait the next release 4.4 for now
-- https://github.com/elenapan/dotfiles/issues/60
--naughty.connect_signal("request::display", function(n)

  --naughty.layout.box {
  --  notification = n,
  --  type = "splash",
  --  widget_template = {}
--  }
--end)
