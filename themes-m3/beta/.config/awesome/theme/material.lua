local theme = {
  name = 'beta',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'beta.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#A3C9FE'
theme.color.on_primary = '#00315B'
theme.color.primary_container = '#1D4875'
theme.color.on_primary_container = '#D3E4FF'
theme.color.secondary = '#BBC7DB'
theme.color.on_secondary = '#263141'
theme.color.secondary_container = '#3C4758'
theme.color.on_secondary_container = '#D7E3F8'
theme.color.tertiary = '#D8BDE3'
theme.color.on_tertiary = '#3C2947'
theme.color.tertiary_container = '#533F5E'
theme.color.on_tertiary_container = '#F4D9FF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#8D9199'
theme.color.background = '#111418'
theme.color.on_background = '#E1E2E8'
theme.color.surface = '#111418'
theme.color.on_surface = '#E1E2E8'
theme.color.surface_variant = '#43474E'
theme.color.on_surface_variant = '#C3C6CF'
theme.color.inverse_surface = '#E1E2E8'
theme.color.inverse_on_surface = '#2E3035'
theme.color.inverse_primary = '#39608F'
theme.color.surface_tint_color = '#A3C9FE'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'

theme.typescale.display_large = { font = 'Iosevka Light', size = 54 }
theme.typescale.display_medium = { font = 'Iosevka Regular', size = 44 }
theme.typescale.display_small = { font = 'Iosevka Regular', size = 36 }
theme.typescale.headline_large = { font = 'Iosevka Heavy', size = 35 }
theme.typescale.headline_medium = { font = 'Iosevka Regular', size = 28 }
theme.typescale.headline_small = { font = 'Iosevka Regular', size = 24 }
theme.typescale.title_large = { font = 'Iosevka Regular', size = 22 }
theme.typescale.title_medium = { font = 'Iosevka Medium', size = 15 }
theme.typescale.title_small = { font = 'Iosevka Medium', size = 14 }
theme.typescale.body_large = { font = 'Iosevka Regular', size = 16 }
theme.typescale.body_medium = { font = 'Iosevka Regular', size = 13 }
theme.typescale.body_small = { font = 'Iosevka Regular', size = 12 }
theme.typescale.label_large = { font = 'Iosevka Medium', size = 14 }
theme.typescale.label_medium = { font = 'Iosevka Medium', size = 12 }
theme.typescale.label_small = { font = 'Iosevka Medium', size = 11 }
theme.typescale.icon = { font = 'Material Design Icons Desktop Regular', size = 14 }

return theme
