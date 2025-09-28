-- A modified version found at:
-- https://github.com/meriadec/awesome-efficient/blob/master/modules/smart-borders.lua
local gears = require("gears")
local cairo = require("lgi").cairo
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local HIDPI = os.getenv("HIDPI") == "1"

local smartBorders = {}

local GUTTER = 5 -- line size
local WEIGHT = 5 -- border size
local STRING_OFFSET = 0 -- padding intern
local ARROW_WEIGHT = 5
local ARROW_WIDTH = beautiful.titlebar_size
local SMART_GAP = 0
local colour_normal = beautiful.double_border_normal or "#111111"
local colour_focus = beautiful.double_border_focus or "#1f1f1f"

if HIDPI then
  GUTTER = 20
  WEIGHT = 0
  ARROW_WEIGHT = 6
  ARROW_WIDTH = 80
  SMART_GAP = 5
end

function smartBorders.set(c, firstRender)
  theEnd(c, "top", firstRender)
  theEnd(c, "left", firstRender)
  theEnd(c, "right", firstRender)
  theEnd(c, "bottom", firstRender)
end

function createFragment(c, position, firstRender, colour)
  local COLOR = gears.color(colour)

  -- We need matches with all Titlebars OFF from the rc.lua
  if c.class == "music_n" and position == "top" then
    GUTTER = 5
  elseif c.class == "Brave-browser" and position == "top" then
    GUTTER = 5
  elseif c.class == "Lutris" and position == "top" then
    GUTTER = 5
  elseif c.class == "music_n" and position == "bottom" then
    GUTTER = beautiful.titlebar_size * 2
  elseif position == "top" then
    GUTTER = beautiful.titlebar_size -- line size
  else
    GUTTER = 5
  end

  local SPACE = GUTTER + WEIGHT
  local G = GUTTER
  local W = c.width
  local H = c.height

  local OFFSET = STRING_OFFSET

  local IMG_W = W + 2 * SPACE
  local IMG_H = H + 2 * SPACE

  local img = cairo.ImageSurface.create(cairo.Format.ARGB32, IMG_W, IMG_H)
  local ctx  = cairo.Context(img)

  ctx:set_source(COLOR)

  if position == "top" then
    ctx:rectangle(0, OFFSET, W + SPACE * 2, WEIGHT)
    ctx:rectangle(SMART_GAP, SMART_GAP, ARROW_WEIGHT, ARROW_WIDTH)
    ctx:rectangle(0, 0, WEIGHT, ARROW_WIDTH + G)
    ctx:rectangle(SMART_GAP, SMART_GAP, ARROW_WIDTH, ARROW_WEIGHT)
    ctx:rectangle(W - ARROW_WEIGHT - SMART_GAP, SMART_GAP, ARROW_WEIGHT, ARROW_WIDTH)
    ctx:rectangle(W - WEIGHT, 0, WEIGHT, ARROW_WIDTH + G)
    ctx:rectangle(W - ARROW_WIDTH - SMART_GAP, SMART_GAP, ARROW_WIDTH, ARROW_WEIGHT)
  elseif position == "bottom" then
    ctx:rectangle(0, SPACE - WEIGHT - OFFSET, W + SPACE * 2, WEIGHT)
    ctx:rectangle(0, 0, WEIGHT, SPACE)
    ctx:rectangle(W - WEIGHT, 0, WEIGHT, SPACE)
    ctx:rectangle(SMART_GAP, 0, ARROW_WEIGHT, SPACE - SMART_GAP)
    ctx:rectangle(SMART_GAP, SPACE - SMART_GAP - ARROW_WEIGHT, ARROW_WIDTH, ARROW_WEIGHT)
    ctx:rectangle(W - ARROW_WIDTH, SPACE - ARROW_WEIGHT - SMART_GAP, ARROW_WIDTH - SMART_GAP, ARROW_WEIGHT)
    ctx:rectangle(W - ARROW_WEIGHT - SMART_GAP, 0, ARROW_WEIGHT, SPACE - SMART_GAP)
  elseif position == "left" then
    ctx:rectangle(OFFSET, 0, WEIGHT, H)
    ctx:rectangle(SMART_GAP, 0, ARROW_WEIGHT, ARROW_WIDTH - SPACE)
    ctx:rectangle(SMART_GAP, H - ARROW_WIDTH - SPACE, ARROW_WEIGHT, ARROW_WIDTH - SPACE)
  elseif position == "right" then
    ctx:rectangle(GUTTER - OFFSET, 0, WEIGHT, H)
    ctx:rectangle(SPACE - ARROW_WEIGHT - SMART_GAP, 0, ARROW_WEIGHT, ARROW_WIDTH - SPACE)
    ctx:rectangle(SPACE - ARROW_WEIGHT - SMART_GAP, H - ARROW_WIDTH - SPACE, ARROW_WEIGHT, ARROW_WIDTH - SPACE)
  end

  ctx:fill()

  return img
end

function theEnd(c, position, firstRender) 
  local img_normal = createFragment(c, position, firstRender, colour_normal)
  local img_focus = createFragment(c, position, firstRender, colour_focus)
  awful.titlebar(c, {
    size = GUTTER + WEIGHT,
    position = position,
    bgimage_normal = img_normal,
    bgimage_focus = img_focus,
  })
  --}) : setup { layout = wibox.layout.align.horizontal, }
end

return smartBorders
