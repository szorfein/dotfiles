local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#deb7ff'
theme.color.on_primary = '#470d79'
theme.color.primary_container = '#5f2c91'
theme.color.on_primary_container = '#f1daff'
theme.color.secondary = '#ecb1ff'
theme.color.on_secondary = '#4d1366'
theme.color.secondary_container = '#662e7f'
theme.color.on_secondary_container = '#f9d8ff'
theme.color.tertiary = '#ffb3a9'
theme.color.on_tertiary = '#5f1411'
theme.color.tertiary_container = '#7e2b25'
theme.color.on_tertiary_container = '#ffdad4'
theme.color.error = '#F2B8B5'
theme.color.on_error = '#601410'
theme.color.error_container = '#8C1D18'
theme.color.on_error_container = '#F9DEDC'
theme.color.outline = '#938F99'
theme.color.background = '#0a121b'
theme.color.on_background = '#e2e2e6'
theme.color.surface = '#0a121b'
theme.color.on_surface = '#e2e2e6'
theme.color.surface_variant = '#49454F'
theme.color.on_surface_variant = '#CAC4D0'
theme.color.inverse_surface = '#e2e2e6'
theme.color.inverse_on_surface = '#1a1c1e'
theme.color.inverse_primary = '#7846ab'
theme.color.surface_tint_color = '#deb7ff'
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

