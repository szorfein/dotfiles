local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#FDA9FF'
theme.color.on_primary = '#580063'
theme.color.primary_container = '#982BA5'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#EFB3EE'
theme.color.on_secondary = '#4B1E4F'
theme.color.secondary_container = '#5D2E60'
theme.color.on_secondary_container = '#FFC1FD'
theme.color.tertiary = '#FFB1C0'
theme.color.on_tertiary = '#660029'
theme.color.tertiary_container = '#AE2653'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#909096'
theme.color.background = '#191118'
theme.color.on_background = '#EEDEE9'
theme.color.surface = '#131314'
theme.color.on_surface = '#E5E2E3'
theme.color.surface_variant = '#45464C'
theme.color.on_surface_variant = '#C6C6CC'
theme.color.inverse_surface = '#E5E2E3'
theme.color.inverse_on_surface = '#313031'
theme.color.inverse_primary = '#992BA5'
theme.color.surface_tint_color = '#FDA9FF'
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
