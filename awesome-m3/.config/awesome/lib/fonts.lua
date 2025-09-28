-- to see font name, use: fc-match -a iosevka

local fonts = {}

function fonts.iosevka()
  local typescale = {
    display_large = { font = 'Iosevka Nerd Font Light', size = 54 },
    display_medium = { font = 'Iosevka Nerd Font Regular', size = 44 },
    display_small = { font = 'Iosevka Nerd Font Regular', size = 36 },
    headline_large = { font = 'Iosevka Nerd Font Heavy', size = 35 },
    headline_medium = { font = 'Iosevka Nerd Font Regular', size = 28 },
    headline_small = { font = 'Iosevka Nerd Font Regular', size = 24 },
    title_large = { font = 'Iosevka Nerd Font Regular', size = 22 },
    title_medium = { font = 'Iosevka Nerd Font Medium', size = 15 },
    title_small = { font = 'Iosevka Nerd Font Medium', size = 14 },
    body_large = { font = 'Iosevka Nerd Font Regular', size = 16 },
    body_medium = { font = 'Iosevka Nerd Font Regular', size = 13 },
    body_small = { font = 'Iosevka Nerd Font Regular', size = 12 },
    label_large = { font = 'Iosevka Nerd Font Medium', size = 14 },
    label_medium = { font = 'Iosevka Nerd Font Medium', size = 12 },
    label_small = { font = 'Iosevka Nerd Font Medium', size = 11 },
    icon = { font = 'Material Design Icons Desktop Regular', size = 14 }
  }

  return typescale
end

return fonts
