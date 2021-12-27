local screen = require("awful.screen")
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local width = screen.focused().geometry.width
local height = screen.focused().geometry.height

local mytheme = {}

mytheme.name = "anonymous"

mytheme.x = {
  background = xrdb.color0 or "#121212",
  surface = xrdb.color0 or "#000000",
  dark_primary = "#222F3C", -- branded dark surface

  primary = xrdb.color6 or "#52dcba", -- cyan
  primary_variant_1 = xrdb.color2 or "#88EFAC", -- primary analog
  primary_variant_2 = xrdb.color4 or "#808FEC", -- primary analog

  secondary = xrdb.color5 or "#E686AC", -- magenta
  secondary_variant_1 = xrdb.color3 or "#DBA68C", -- secondary analog
  secondary_variant_2 = xrdb.color13 or "#EB86FC", -- secondary analog

  error = xrdb.color1 or "#CF6673",
  error_variant_1 = xrdb.color9 or "#BFA6B3",

  on_background = xrdb.color15 or "#ffffff", -- white
  on_surface = xrdb.color15,  -- white
  on_primary = xrdb.color0 or "#111111", -- black
  on_secondary = xrdb.color0 or "#111111",  -- black
  on_error = xrdb.color0 or "#111111", -- black
}

-- fonts
mytheme.f = {
  h1 = (height >= 1024 and "Iosevka Light 56" or "Iosevka Light 40"), -- used on big icon or big title
  h4 = "Iosevka Regular 32",
  h5 = "Material Design Icons Desktop Regular 20", -- icon for h6
  h6 = "Iosevka Regular 20",
  subtile_1 = "Iosevka Regular 13", -- used on text list
  subtile_2 = (height >= 1024 and "Iosevka Light 10" or "Iosevka Light 9"), -- used tasklist
  body_1 = "Iosevka Term Medium 15", -- used on text body title
  body_2 = (height >= 1024 and "Iosevka Regular 14" or "Iosevka Medium 13"), -- used on text body
  icon = "Material Design Icons Desktop Regular 15", -- used for icon
  button = (height >= 1024 and "Iosevka Regular 13" or "Iosevka Regular 12"), -- used on text with icon
  caption = "Iosevka Bold 12", -- used on annotation
  overline = "Iosevka Regular 10",
}

-- text emphasis
mytheme.t = {
  high = 87,
  medium = 60,
  disabled = 38
}

-- elevation overlay
mytheme.e = {
  dp00 = "00",
  dp01 = "0D",
  dp02 = "12",
  dp03 = "14",
  dp04 = "17",
  dp06 = "1C",
}

return mytheme
