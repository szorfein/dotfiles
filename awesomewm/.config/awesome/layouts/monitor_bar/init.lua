return function(s)
  if M.name == "lines" then
    require("layouts.monitor_bar.full")(s)
  elseif M.name == "morpho" then
    require("layouts.monitor_bar.horizontal")(s)
  elseif M.name == "worker" then
    require("layouts.monitor_bar.horizontal_v2")(s)
  elseif M.name == "astronaut" then
    require("layouts.monitor_bar.astronaut")(s)
  else
    require("layouts.monitor_bar.horizontal")(s)
    s.monitor_bar.visible = false
  end
end 
