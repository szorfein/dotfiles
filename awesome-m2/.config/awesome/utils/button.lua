local wibox = require("wibox")
local awful = require("awful")
local table = require("gears.table")
local helper = require("utils.helper")
local font = require("utils.font")
local mat_bg = require("utils.material.background")
local mat_fg = require("utils.material.foreground")

local mat_button = class()

-- opacity color on dark theme
-- https://material.io/design/iconography/system-icons.html#color
local mat_mode = { text = {}, contained = {}, outlined = {} }
mat_mode.text.margin = { right = 8, left = 8 }
mat_mode.text.fg = { disabled = 60, hovered = 87 , focused = 100 }
mat_mode.contained.margin = { right = 16, left = 16 }
mat_mode.contained.fg = { disabled = 90, hovered = 95 , focused = 100 }
mat_mode.outlined.margin = { right = 16, left = 16 }
mat_mode.outlined.fg = { disabled = 60, hovered = 87 , focused = 100 }

function mat_button:init(args)
  -- options
  self.icon = args.icon or font.button("")
  self.text = args.text or font.button("")
  self.fg_icon = args.fg_icon or M.x.on_surface
  self.fg_text = args.fg_text or self.fg_icon
  self.bg = args.bg or M.x.primary -- used only on mode "contained"
  self.layout = args.layout or "vertical"
  self.rrect = args.rrect or 10
  self.width = args.width or nil
  self.height = args.height or nil -- default height 36
  self.spacing = args.spacing or 0
  self.command = args.command or nil
  -- button mode https://material.io/components/buttons/#
  self.mode = args.mode or 'text' -- mode are: contained , outlined or text
  self.margins = args.margins or 10
  -- widgets
  self.margin = wibox.widget {
    margins = self.margins,
    forced_height = self.height,
    forced_width = self.width,
    widget = wibox.container.margin
  }
  self.w = self:make_widget()
end

function mat_button:make_widget()
  if self.mode == "contained" then
    return self:init_contained()
  elseif self.mode == "outlined" then
    return self:init_outlined()
  else
    return self:init_text()
  end
end

function mat_button:init_contained()
  return wibox.widget {
    {
      {
        {
          self.icon,
          fg = self.fg_icon,
          widget = wibox.container.background
        },
        left = self.margins,
        right = self.margins,
        top = self.margins / 3,
        bottom = self.margins / 3,
        widget = wibox.container.margin
      },
      bg = self.bg .. "CC", -- 80%
      shape = helper.rrect(self.rrect),
      widget = wibox.container.background
    },
    widget = wibox.container.margin
  }
end

function mat_button:init_outlined()
  return wibox.widget {
    {
      {
        self.icon,
        widget = mat_fg({ color = self.fg_icon }),
      },
      widget = self.margin
    },
    shape_border_width = 1,
    --shape_border_color = self.fg_icon,
    widget = mat_bg({ color = self.fg_icon, shape = helper.rrect(self.rrect) }),
  }
end

function mat_button:init_text()
  return wibox.widget {
    {
      {
        {
          self.icon,
          {
            self.text,
            widget = mat_fg({ color = self.fg_text }),
          },
          spacing = self.spacing,
          layout = wibox.layout.fixed[self.layout],
        },
        widget = mat_fg({ color = self.fg_icon }),
      },
      widget = self.margin
    },
    widget = mat_bg({ color = self.fg_icon, shape = helper.rrect(self.rrect) }),
  }
end

function mat_button:add_action()
  if self.command == nil then return end
  self.w:buttons(table.join(
    awful.button({}, 1, function() 
      self.command()
    end)
  ))
end

local new_button = class(mat_button)

function new_button:init(args)
  mat_button.init(self, args)
  mat_button.add_action(self)
  return self.w
end

return new_button
