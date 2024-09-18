#!/usr/bin/env sh

set -o errexit

[ -z "$1" ] && {
  echo "Need a json file as argument"
  exit 1
}

[ -f "$1" ] || {
  echo "File $1 do not exist."
  exit 1
}

filename="$1"

getjq() {
  color=$(cat < "$filename" | jq ".schemes.dark.$1" | tr -d '"')
  echo "$color" | tr -d '"'
}

# all variables...
primary=$(getjq 'primary')
surfaceTint=$(getjq 'surfaceTint')
onPrimary=$(getjq 'onPrimary')
primaryContainer=$(getjq 'primaryContainer')
onPrimaryContainer=$(getjq 'onPrimaryContainer')
secondary=$(getjq 'secondary')
onSecondary=$(getjq 'onSecondary')
secondaryContainer=$(getjq 'secondaryContainer')
onSecondaryContainer=$(getjq 'onSecondaryContainer')
tertiary=$(getjq 'tertiary')
onTertiary=$(getjq 'onTertiary')
tertiaryContainer=$(getjq 'tertiaryContainer')
onTertiaryContainer=$(getjq 'onTertiaryContainer')
error=$(getjq 'error')
onError=$(getjq 'onError')
errorContainer=$(getjq 'errorContainer')
onErrorContainer=$(getjq 'onErrorContainer')
background=$(getjq 'background')
onBackground=$(getjq 'onBackground')
surface=$(getjq 'surface')
onSurface=$(getjq 'onSurface')
surfaceVariant=$(getjq 'surfaceVariant')
onSurfaceVariant=$(getjq 'onSurfaceVariant')
outline=$(getjq 'outline')
outlineVariant=$(getjq 'outlineVariant')
shadow=$(getjq 'shadow')
scrim=$(getjq 'scrim')
inverseSurface=$(getjq 'inverseSurface')
inverseOnSurface=$(getjq 'inverseOnSurface')
inversePrimary=$(getjq 'inversePrimary')
primaryFixed=$(getjq 'primaryFixed')
onPrimaryFixed=$(getjq 'onPrimaryFixed')
primaryFixedDim=$(getjq 'primaryFixedDim')
onPrimaryFixedVariant=$(getjq 'onPrimaryFixedVariant')
secondaryFixed=$(getjq 'secondaryFixed')
onSecondaryFixed=$(getjq 'onSecondaryFixed')
secondaryFixedDim=$(getjq 'secondaryFixedDim')
onSecondaryFixedVariant=$(getjq 'onSecondaryFixedVariant')
tertiaryFixed=$(getjq 'tertiaryFixed')
# please kill me !!!
onTertiaryFixed=$(getjq 'onTertiaryFixed')
tertiaryFixedDim=$(getjq 'tertiaryFixedDim')
onTertiaryFixedVariant=$(getjq 'onTertiaryFixedVariant')
surfaceDim=$(getjq 'surfaceDim')
surfaceBright=$(getjq 'surfaceBright')
surfaceContainerLowest=$(getjq 'surfaceContainerLowest')
surfaceContainerLow=$(getjq 'surfaceContainerLow')
surfaceContainer=$(getjq 'surfaceContainer')
surfaceContainerHigh=$(getjq 'surfaceContainerHigh')
surfaceContainerHighest=$(getjq 'surfaceContainerHighest')
# PAUSE

WORKDIR=/tmp/new-theme
echo "Creating required directory at $WORKDIR..."
[ -d "$WORKDIR" ] && rm -r "$WORKDIR"
mkdir -p "$WORKDIR/.Xresources.d"
mkdir -p "$WORKDIR/.config/awesome/theme"
mkdir -p "$WORKDIR/.config/zathura"
mkdir -p "$WORKDIR/.tmux"
mkdir -p "$WORKDIR/.vim"

echo "Generating Xresource..."
cat <<EOF > "$WORKDIR/.Xresources.d/fonts"
st.font: Iosevka Term:pixelsize=14:autohint=true;
EOF

cat <<EOF > "$WORKDIR/.Xresources.d/colors"
#define base00 $background
#define base01 $surfaceContainer
#define base02 $surfaceContainerHigh
#define base03 $surfaceContainerHighest
#define base04 $onBackground
#define base05 $onBackground
#define base06 $onPrimaryContainer
#define base07 $onSecondaryContainer
#define base08 $onSecondaryContainer
#define base09 $secondary
#define base0A $secondary
#define base0B $error
#define base0C $error
#define base0D $tertiary
#define base0E $secondaryFixedDim
#define base0F $primary
EOF

echo "Generation awesome m3..."
cat <<EOF > "$WORKDIR/.config/awesome/theme/beautiful.lua"
---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require('gears')
local dpi = xresources.apply_dpi
local helpers = require('lib.helpers')

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = md.sys.typescale.body_medium.font
  .. ' ' .. md.sys.typescale.body_medium.size

theme.bg_normal     = md.sys.color.background
theme.bg_focus      = md.sys.color.on_background .. md.sys.elevation.level1
theme.bg_urgent     = md.sys.color.tertiary
theme.bg_minimize   = md.sys.color.on_surface .. md.sys.state.disable_container_opacity
theme.bg_systray    = md.sys.color.background

theme.fg_normal     = md.sys.color.on_background
theme.fg_focus      = md.sys.color.on_background
theme.fg_urgent     = md.sys.color.on_tertiary
theme.fg_minimize   = md.sys.color.on_surface .. md.sys.state.disable_content_opacity

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(1)
theme.border_normal = md.sys.color.shadow
theme.border_focus  = md.sys.color.surface_variant
theme.border_marked = md.sys.color.inverse_surface

-- Generate taglist squares:
local taglist_square_size = dpi(8)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, md.sys.color.error
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, md.sys.color.error
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = md.wallpaper

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
EOF

cat <<EOF > "$WORKDIR/.config/awesome/theme/material.lua"
local theme = {
  name = 'new-theme',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'beta.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '$primary'
theme.color.on_primary = '$onPrimary'
theme.color.primary_container = '$primaryContainer'
theme.color.on_primary_container = '$onPrimaryContainer'
theme.color.secondary = '$secondary'
theme.color.on_secondary = '$onSecondary'
theme.color.secondary_container = '$secondaryContainer'
theme.color.on_secondary_container = '$onSecondaryContainer'
theme.color.tertiary = '$tertiary'
theme.color.on_tertiary = '$onTertiary'
theme.color.tertiary_container = '$tertiaryContainer'
theme.color.on_tertiary_container = '$onTertiaryContainer'
theme.color.error = '$error'
theme.color.on_error = '$onError'
theme.color.error_container = '$errorContainer'
theme.color.on_error_container = '$onErrorContainer'
theme.color.outline = '$outline'
theme.color.background = '$background'
theme.color.on_background = '$onBackground'
theme.color.surface = '$surface'
theme.color.on_surface = '$onSurface'
theme.color.surface_variant = '$surfaceVariant'
theme.color.on_surface_variant = '$onSurfaceVariant'
theme.color.inverse_surface = '$inverseSurface'
theme.color.inverse_on_surface = '$inverseOnSurface'
theme.color.inverse_primary = '$inversePrimary'
theme.color.surface_tint_color = '$surfaceTint'
theme.color.shadow = '$shadow'

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
EOF

echo "Generating zathura..."
cat <<EOF > "$WORKDIR/.config/zathura/zathurarc"
set font "Iosevka Term 10"
set default-bg "$background"
set default-fg "$onBackground"
set statusbar-fg "$onSurfaceVariant"
set statusbar-bg "$surfaceVariant"
set inputbar-fg "$secondary"
set notification-error-bg "$tertiary"
set notification-error-fg "$onTertiary"
set notification-warning-bg "$error"
set notification-warning-fg "$onError"
set highlight-color "$secondary"
set highlight-active-color "$primary"
set recolor "true"
set recolor-lightcolor "$background"
set recolor-darkcolor "$onBackground"
set recolor-keephue "true"
set recolor-reverse-video "true"
EOF

echo "Generating tmux..."
cat <<EOF > "$WORKDIR/.tmux/status"
# Customized from https://github.com/arcticicestudio/nord-tmux
TMUX_STATUS_TIME_FORMAT="%I:%M.%p"

#+--------+
#+ Status +
#+--------+
#+--- Layout ---+
set -g status-justify left

#+-------+
#+ Panes +
#+-------+
set -g pane-border-style bg=$background,fg=$surfaceContainerHigh
set -g pane-active-border-style bg=$background,fg=$secondary
set -g display-panes-colour $surfaceContainer
set -g display-panes-active-colour $surfaceContainerHigh

#+----------+
#+ Messages +
#+----------+
set -g message-style bg=$surfaceContainerHigh,fg=$primary
set -g message-command-style bg=$surfaceContainerHigh,fg=$primary

#+--------+
#+ Status +
#+--------+
#+ Bar ---+
set -g status-left "#[fg=$onPrimaryContainer,bg=$primaryContainer,bold] #S #[fg=$primaryContainer,bg=$surfaceContainer,nobold,noitalics,nounderscore]"

set -g status-right "#[fg=$surfaceContainerHigh,bg=$surfaceContainer,nobold,noitalics,nounderscore]#[fg=$onSurface,bg=$surfaceContainerHigh]#[fg=$onSurface,bg=$surfaceContainerHigh] ${TMUX_STATUS_TIME_FORMAT} #[fg=$primary,bg=$surfaceContainer,nobold,noitalics,nounderscore]#[fg=$background,bg=$primary,bold] #H "

#+ Window +
set -g window-status-format "#[fg=black,bg=brightblack,nobold,noitalics,nounderscore] #[fg=white,bg=brightblack]#I #[fg=white,bg=brightblack,nobold,noitalics,nounderscore] #[fg=white,bg=brightblack]#W #F #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=black,bg=brightcyan,nobold,noitalics,nounderscore] #[fg=black,bg=brightcyan]#I #[fg=black,bg=brightcyan,nobold,noitalics,nounderscore] #[fg=black,bg=brightcyan]#W #F #[fg=brightcyan,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-separator ""
EOF

echo "Generation vim..."
cat <<EOF > "$WORKDIR/.vim/colorscheme"
" Color
colorscheme ombre

" Reload colorscheme
map <F8> :update<CR>:colorscheme ombre<CR>
EOF

cat <<EOF > "$WORKDIR/.vim/lightline-theme.vim"
let g:lightline.colorscheme = 'ombre'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']] }

let g:lightline.separator = { 'right': '', 'left': '' }
let g:lightline.subseparator = { 'right': ' ', 'left': '' }

let g:lightline.active = {
  \   'left': [
  \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \   [ 'gitbranch' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileencoding', 'fileformat', 'filetype' ] ],
  \ }

" https://github.com/ryanoasis/vim-devicons/wiki/usage#lightline-setup
let g:lightline.component_function = {
  \   'gitbranch': 'gitbranch#name',
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \ }

let g:lightline.inactive = {
  \   'left': [ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \           [ 'filename_active' ] ],
  \   'right':[['lineinfo']],
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
EOF
