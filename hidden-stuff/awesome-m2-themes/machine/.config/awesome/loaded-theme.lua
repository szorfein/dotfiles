local screen = require("awful.screen")
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local width = screen.focused().geometry.width
local height = screen.focused().geometry.height

local mytheme = {}

mytheme.name = "machine"

-- xrdb variables and fallback
mytheme.x = {
  background = xrdb.color0 or "#121212",
  surface = xrdb.color0 or "#000000",
  dark_primary = "#1E1A30", -- branded dark surface

  primary = xrdb.color6 or "#52dcba", -- cyan
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
  h1 = "SpaceMono Nerd Font Mono 60", -- used rarely on big icon or big title
  h4 = "SpaceMono Nerd Font Mono 32",
  h5 = "Material Design Icons Regular 20", -- icon for h6
  h6 = "SpaceMono Nerd Font Mono 20",
  subtile_1 = "SpaceMono Nerd Font Mono 12", -- used on text list
  subtile_2 = (height >= 1024 and "SpaceMono Nerd Font Mono 12" or "SpaceMono Nerd Font Mono 10"), -- used tasklist
  body_1 = "SpaceMono Bold Nerd Font Mono 16", -- used on text body title
  body_2 = "SpaceMono Nerd Font Mono 14", -- used on text body
  icon = "Material Design Icons Regular 15", -- used for icon
  button = "SpaceMono Nerd Font Mono Regular 14", -- used on text button
  caption = "SpaceMono Nerd Font Mono Bold 12", -- used on annotation
  overline = "SpaceMono Nerd Font Mono 10",
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
  dp00 = "00", -- 0%
  dp01 = "0D", -- 5%
  dp02 = "12", -- 7%
  dp03 = "14", -- 8%
  dp04 = "17", -- 9%
  dp06 = "1C", -- 11%
}

return mytheme
