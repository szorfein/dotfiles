local theme = {
  name = 'worker',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'worker.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#4fd8ea'
theme.color.on_primary = '#00363d'
theme.color.primary_container = '#004f58'
theme.color.on_primary_container = '#8ef1ff'
theme.color.secondary = '#b1cbd0'
theme.color.on_secondary = '#1c3438'
theme.color.secondary_container = '#334b4f'
theme.color.on_secondary_container = '#cde7ec'
theme.color.tertiary = '#bac6eb'
theme.color.on_tertiary = '#24304d'
theme.color.tertiary_container = '#3a4665'
theme.color.on_tertiary_container = '#d8e2ff'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#899294'
theme.color.background = '#191c1d'
theme.color.on_background = '#e0e3e3'
theme.color.surface = '#191c1d'
theme.color.on_surface = '#e0e3e3'
theme.color.surface_variant = '#3f484a'
theme.color.on_surface_variant = '#bfc8ca'
theme.color.inverse_surface = '#e0e3e3'
theme.color.inverse_on_surface = '#191c1d'
theme.color.inverse_primary = '#006874'
theme.color.surface_tint_color = '#4fd8ea'
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

