local wibox = require("wibox")

local root_text = class()

-- Code for transparency
-- https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
local emphasis = {
  [ "high" ] = "DE", -- 87%
  [ "medium" ] = "99", -- 60%
  [ "disabled" ] = "61", -- 38%
  [ "error" ] = "FF", -- 100%
}

-- text emphasis
-- https://material.io/design/color/dark-theme.html#ui-application
function root_text:init(args)
  self.color = args.color or M.x.on_surface
  self.lv = args.lv or "high" -- emphasis level
  self.w = wibox.widget {
    fg = self.color .. emphasis[self.lv],
    widget = wibox.container.background
  }
end

local mat_text = class(root_text)

function mat_text:init(args)
  root_text.init(self, args)
  return self.w
end

return mat_text
