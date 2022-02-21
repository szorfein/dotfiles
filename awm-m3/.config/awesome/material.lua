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
    primary = '#acc7ff',
    primary_container = '#004397',
    secondary = '#bfc6dc',
    secondary_container = '#3f4759',
    tertiary = '#debbdf',
    tertiary_container = '#583e5b',
    surface = '#1b1b1e',
    surface_variant = '#44474f',
    background = '#1b1b1e',
    error = '#ffb4a9',
    error_container = '#930006',
    on_primary = '#002e6c',
    on_primary_container = '#d6e2ff',
    on_secondary = '#283041',
    on_secondary_container = '#dae2f9',
    on_tertiary = '#402843',
    on_tertiary_container = '#fbd7fb',
    on_surface = '#e4e2e6',
    on_surface_variant = '#c4c6d0',
    on_error = '#680003',
    on_error_container = '#ffdad4',
    on_background = '#e4e2e6',
    outline = '#8e9099',
    shadow = '#000000',
    inverse_surface = '#e4e2e6',
    inverse_on_surface = '#1b1b1e',
    inverse_primary = '#005ac5',
    surface_tint_color = '#acc7ff' -- same primary
  },
  state = { -- https://m3.material.io/foundations/interaction-states
    hover_state_layer_opacity   = '14', -- 8%
    focus_state_layer_opacity   = '1F', -- 12%
    pressed_state_layer_opacity = '1F', -- 12%
    dragged_state_layer_opacity = '24', -- 14%
    disable_content_opacity = '61',   -- 38% on color.on_*
    disable_container_opacity = '1F', -- 12% on color.on_*
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
    label_large = {
      font = 'Iosevka',
      size = dpi(14)
    },
    label_medium = {
      font = 'Iosevka Medium',
      size = dpi(14)
    },
    label_small = {},
    body_large = {
      font = 'Iosevka Bold',
      size = dpi(18)
    },
    body_medium = {
      font = 'Iosevka Medium',
      size = 12
    },
    body_small = {},
  },
}

return theme
