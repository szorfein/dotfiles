local button = require("utils.button")
local font = require("utils.font")
local icons = require("config.icons")

local launcher_root = class()

function launcher_root:init()
  self.w = button({
    fg_icon = M.x.primary,
    icon = font.icon(icons.widget.launcher),
    command = nav_drawer_show,
    layout = "horizontal",
    rrect = 5,
    margins = dpi(8)
  })
end

local launcher_widget = class(launcher_root)

function launcher_widget:init()
  launcher_root.init(self)
  return self.w
end

return launcher_widget
