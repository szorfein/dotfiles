local theme = require('theme.theme')

local material = {}

material.wallpaper = theme.wallpaper

-- transparent code (hexa) https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

-- Design Token
-- https://m3.material.io/foundations/design-tokens/overview
material.sys = {
  elevation = { -- https://material.io/design/color/dark-theme.html#properties
    level0 = '00',
    level1 = '0D', -- +5%
    level2 = '12', -- +7%
    level3 = '14', -- +8%
    level4 = '17'  -- +9%
  },
  color = theme.color, -- https://m3.material.io/styles/color/the-color-system/tokens
  state = { -- https://m3.material.io/foundations/interaction-states
    hover_state_layer_opacity   = '14', -- 8%
    focus_state_layer_opacity   = '1F', -- 12%
    pressed_state_layer_opacity = '1F', -- 12%
    dragged_state_layer_opacity = '24', -- 16%
    disable_content_opacity = '61',   -- 38% on color.on_*
    disable_container_opacity = '1F', -- 12% on color.on_*
  },
  typescale = theme.typescale, -- https://m3.material.io/styles/typography/tokens
}

return material
