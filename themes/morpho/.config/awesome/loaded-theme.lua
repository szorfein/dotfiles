local screen = require("awful.screen")
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local width = screen.focused().geometry.width
local height = screen.focused().geometry.height

local mytheme = {}

mytheme.name = "morpho"

-- xrdb variables and fallback
mytheme.x = {
  background = xrdb.background or "#121212",
  surface = xrdb.background or "#000000",
  dark_primary = "#28233D", -- branded dark surface

  primary = xrdb.color6 or "#9afff9", -- cyan
  primary_variant_1 = xrdb.color2 or "#88EFAC", -- primary analog
  primary_variant_2 = xrdb.color4 or "#808FEC", -- primary analog

  secondary = xrdb.color5 or "#E686AC", -- magenta
  secondary_variant_1 = xrdb.color3 or "#DBA68C", -- secondary analog
  secondary_variant_2 = xrdb.color13 or "#EB86FC", -- secondary analog

  error = xrdb.color1 or "#BF96B3",
  error_variant_1 = xrdb.color9 or "#BFA6B3",

  on_background = xrdb.color15 or "#ffffff", -- white
  on_surface = xrdb.color15,  -- white
  on_primary = xrdb.color0, -- black
  on_secondary = xrdb.color0,  -- black
  on_error = xrdb.color0 -- white
}

-- fonts
mytheme.f = {
  h1 = "Iosevka Light 60", -- used rarely on big icon or big title
  h4 = "Iosevka Regular 32",
  h5 = "Material Design Icons Desktop Regular 20", -- icon for h6
  h6 = "Iosevka Regular 20",
  subtile_1 = "Iosevka Regular 13", -- used on text list
  subtile_2 = (height >= 1024 and "Iosevka Light 10" or "Iosevka Light 9"), -- used tasklist
  body_1 = "Iosevka Term Regular 16", -- used on text body title
  body_2 = "Iosevka Term Light 14", -- used on text body
  icon = "Material Design Icons Desktop Regular 13", -- used for icon
  button = "Iosevka Term Regular 15", -- used on text button
  caption = "Iosevka Regular 12", -- used on annotation
  overline = "Iosevka Regular 10",
}

-- text emphasis
-- https://material.io/design/color/dark-theme.html#ui-application
mytheme.t = {
  high = 87,
  medium = 60,
  disabled = 38
}

-- elevation overlay transparency in hexa code
-- https://material.io/design/color/dark-theme.html#properties
mytheme.e = {
  dp00 = "00",
  dp01 = "0D",
  dp02 = "12",
  dp03 = "14",
  dp04 = "17",
  dp06 = "1C",
}

return mytheme
