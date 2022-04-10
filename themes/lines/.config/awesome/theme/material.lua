local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#C08BF6'
theme.color.on_primary = '#4e169c'
theme.color.primary_container = '#591DA4'
theme.color.on_primary_container = '#DCB8FF'
theme.color.secondary = '#D58FE9'
theme.color.on_secondary = '#6A0EB0'
theme.color.secondary_container = '#7D0FB8'
theme.color.on_secondary_container = '#E6BCF1'
theme.color.tertiary = '#D0F1AC'
theme.color.on_tertiary = '#193800'
theme.color.tertiary_container = '#79B845'
theme.color.on_tertiary_container = '#E3F6CC'
theme.color.error = '#F2B8B5'
theme.color.on_error = '#601410'
theme.color.error_container = '#8C1D18'
theme.color.on_error_container = '#F9DEDC'
theme.color.outline = '#938F99'
theme.color.background = '#0A121B'
theme.color.on_background = '#E6EEFE'
theme.color.surface = '#0A121B'
theme.color.on_surface = '#E6EEFE'
theme.color.surface_variant = '#49454F'
theme.color.on_surface_variant = '#CAC4D0'
theme.color.inverse_surface = '#e3e2e6'
theme.color.inverse_on_surface = '#1a1b1f'
theme.color.inverse_primary = '#754B9D'
theme.color.surface_tint_color = '#dfb6ff'
theme.color.shadow = '#000000'

theme.typescale.display_large = { font = 'Iosevka Regular', size = 56 }
theme.typescale.display_medium = { font = 'Iosevka Regular', size = 44 }
theme.typescale.display_small = { font = 'Iosevka Regular', size = 36 }
theme.typescale.headline_large = { font = 'Iosevka Regular', size = 32 }
theme.typescale.headline_medium = { font = 'Iosevka Regular', size = 28 }
theme.typescale.headline_small = { font = 'Iosevka Regular', size = 24 }
theme.typescale.title_large = { font = 'Iosevka Regular', size = 22 }
theme.typescale.title_medium = { font = 'Iosevka Medium', size = 15 }
theme.typescale.title_small = { font = 'Iosevka Medium', size = 14 }
theme.typescale.body_large = { font = 'Iosevka Regular', size = 16 }
theme.typescale.body_medium = { font = 'Iosevka Regular', size = 14 }
theme.typescale.body_small = { font = 'Iosevka Regular', size = 12 }
theme.typescale.label_large = { font = 'Iosevka Medium', size = 14 }
theme.typescale.label_medium = { font = 'Iosevka Medium', size = 12 }
theme.typescale.label_small = { font = 'Iosevka Medium', size = 11 }
theme.typescale.icon = { font = 'Material Design Icons Desktop Regular', size = 14 }

return theme

