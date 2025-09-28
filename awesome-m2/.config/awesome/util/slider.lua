-- source: https://github.com/PapyElGringo/material-awesome/blob/8cd624d51ce3d525d38258890d13656ccd7aeb11/widget/material/slider.lua
-- Default widget requirements
local base = require('wibox.widget.base')
local gtable = require('gears.table')
local setmetatable = setmetatable
local widget = require("util.widgets")

-- Commons requirements
local wibox = require('wibox')
local gears = require('gears')
-- Local declarations

local mat_slider = {mt = {}}

local properties = {
  read_only = false
}

function mat_slider:set_value(value)
  if self._private.value ~= value then
    self._private.value = value
    self._private.progress_bar:set_value(self._private.value)
    self._private.slider:set_value(self._private.value)
    self:emit_signal('property::value')
  --self:emit_signal('widget::layout_changed')
  end
end

function mat_slider:get_value(value)
  return self._private.value
end

function mat_slider:set_read_only(value)
  if self._private.read_only ~= value then
    self._private.read_only = value
    self:emit_signal('property::read_only')
    self:emit_signal('widget::layout_changed')
  end
end

function mat_slider:get_read_only(value)
  return self._private.read_only
end

function mat_slider:layout(_, width, height)
  local layout = {}
  table.insert(layout, base.place_widget_at(self._private.progress_bar, 0, dpi(21), width, height - dpi(42)))
  if (not self._private.read_only) then
    table.insert(layout, base.place_widget_at(self._private.slider, 0, dpi(6), width, height - dpi(12)))
  end
  return layout
end

function mat_slider:draw(_, cr, width, height)
  if (self._private.read_only) then
    self._private.slider.forced_height = 0
  end
end

function mat_slider:fit(_, width, height)
  return width, height
end

local function new(args)
  local ret =
    base.make_widget(
    nil,
    nil,
    {
      enable_properties = true
    }
  )

  gtable.crush(ret._private, args or {})

  gtable.crush(ret, mat_slider, true)

  ret._private.progress_bar = widget.make_progressbar(_, 200, ret._private.color)
  ret._private.progress_bar.background_color = ret._private.color .. "33" -- 20%
  ret._private.progress_bar.paddings = 0
  ret._private.progress_bar.border_with = 0

  ret._private.slider = widget.make_a_slider(15, ret._private.color)
  ret._private.slider.background_color = ret._private.color.. "33" -- 20%
  ret._private.slider.handle_border_color = '#00000012',

  ret._private.slider:connect_signal(
    'property::value',
    function()
      ret:set_value(ret._private.slider.value)
    end
  )

  ret._private.read_only = false

  return ret
end

function mat_slider.mt:__call(...)
  return new(...)
end

return setmetatable(mat_slider, mat_slider.mt)
