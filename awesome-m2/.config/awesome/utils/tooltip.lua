local atooltip = require("awful.tooltip")
local helper = require("utils.helper")

local tooltip = {}

-- spec: https://material.io/components/tooltips/
function tooltip.create(w)
  if not w then return end
  return atooltip {
    markup = 0,
    visible = false,
    shape = helper.rrect(50),
    timeout = 4,
    margin_leftright = 16,
    margin_topbottom = 10,
    font = M.f.caption,
    --bg = M.x.dark_primary,
    bg = M.x.dark_primary,
    fg = M.x.on_background .. "B3", -- 70%
    objects = { w }
  }
end

return tooltip
