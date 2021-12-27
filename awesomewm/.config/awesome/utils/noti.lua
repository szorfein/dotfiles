local naughty = require("naughty")
local helper = require("utils.helper")

-- configs
naughty.config.presets.low = {
  font = M.f.body_2,
  fg = M.x.on_surface,
  bg = M.x.dark_primary,
  margin = 14,
  shape = helper.rrect(6),
  border_color = M.x.surface
}

naughty.config.presets.normal = {
  font = M.f.subtile_1,
  fg = M.x.on_surface,
  bg = M.x.surface,
  margin = 16,
  border_color = M.x.secondary_variant_2,
  shape = helper.rrect(6),
}

naughty.config.presets.critical = {
  font = M.f.subtile_1,
  fg = M.x.on_surface,
  bg = M.x.error,
  margin = 16,
  shape = helper.rrect(6),
}

naughty.config.presets.info = naughty.config.presets.low

local noti = {}

-- called snackbars in material, low emphasis
-- https://material.io/components/snackbars/#specs
function noti.info(msg)
  naughty.notify({
    text = tostring(msg),
    position = "bottom_middle",
    preset = naughty.config.presets.low
 })
end

function noti.error(msg)
  naughty.notify({
    text = tostring(msg),
    position = "top_right",
    preset = naughty.config.presets.normal
  })
end

function noti.warn(msg)
  naughty.notify({
    title = "Warning",
    text = tostring(msg),
    position = "top_right",
    preset = naughty.config.presets.normal
  })
end

function noti.critical(msg)
  naughty.notify({
    title = "Oops, there were errors during startup!",
    text = tostring(msg),
    position = "top_right",
    preset = naughty.config.presets.critical
  })
end

return noti
