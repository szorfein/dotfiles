local awful = require("awful")
local noti = require("utils.noti")
local table = require("gears.table")
local icons = require("config.icons")
local button = require("utils.button")
local font = require("utils.font")

-- widget creation
local scrot_icon = button({
  fg_icon = M.x.on_background,
  icon = font.button(icons.widget.scrot),
  layout = "horizontal"
})

function take_scrot(time) 
  local time = time or 0
  local title = "Screenshot is taken." -- default
  if time >= 1 then
    title = "Screenshot taken in "..time.." sec(s)..."
  end
  awful.spawn.with_shell("scrot -d "..time.." -q 100")
  noti.info(title)
end

scrot_icon:buttons(table.join(
  awful.button({ }, 1, function() -- left click
    take_scrot() 
  end),
  awful.button({}, 2, function() -- middle click
    take_scrot(3)
  end),
  awful.button({}, 3, function() -- right 
    take_scrot(1)
  end)
))

return scrot_icon
