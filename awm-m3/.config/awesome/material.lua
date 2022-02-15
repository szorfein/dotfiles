local theme = {}

theme.name = 'beta'

-- transparent code (hexa) https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

-- Design Token
-- https://m3.material.io/foundations/design-tokens/overview
theme.sys = {
  elevation = { -- https://material.io/design/color/dark-theme.html#properties
    level0 = '00',
    level1 = '0D', -- +5%
    level2 = '12', -- +7%
    level3 = '14', -- +8%
    level4 = '17'  -- +9%
  },
  color = { -- https://m3.material.io/styles/color/the-color-system/tokens
    primary = '#80c1bf',
    primary_container = '',
    secondary = '',
    secondary_container = '',
    tertiary = '',
    tertiary_container = '',
    surface = '',
    surface_variant = '',
    background = '',
    error = '',
    error_container = '',
    on_primary = '',
    on_primary_container = '',
    on_secondary = '',
    on_secondary_container = '',
    on_tertiary = '',
    on_surface = '',
    on_surface_variant = '',
    on_error = '',
    on_error_container = '',
    on_background = '',
    outline = '',
    shadow = '#010101',
    inverse_surface = '',
    inverse_on_surface = '',
    inverse_primary = ''
  },
  state = { -- https://m3.material.io/foundations/interaction-states
    hover_state_layer_opacity   = '14', -- 8%
    focus_state_layer_opacity   = '1F', -- 12%
    pressed_state_layer_opacity = '1F', -- 12%
    dragged_state_layer_opacity = '24', -- 14%
  },
  typescale = { -- https://m3.material.io/styles/typography/tokens
    display_large = {
      font = 'Iosevka Light',
      size = 56,
    },
    display_medium = {
      font = '',
      size = 40,
    },
    display_small = {},
    headline_large = {},
    headline_medium = {},
    headline_small = {},
    title_large = {},
    title_medium = {},
    title_small = {},
    label_large = {},
    label_medium = {},
    label_small = {},
    body_large = {},
    body_medium = {
      font = 'Iosevka Medium',
      size = 14
    },
    body_small = {},
  },
}

return theme
