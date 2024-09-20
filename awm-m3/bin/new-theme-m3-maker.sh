#!/usr/bin/env sh

set -o errexit

die() { echo "$1"; exit 1; }

usage() {
  printf "  %s\\t%s\\n" "-n, --name NAME" "A name for the new theme."
  printf "  %s\\t%s\\n" "-f, --file PATH" "A JSON file from a material theme."
  printf "  %s\\t%s\\n" "-t, --tmux THEME" "try: 'bubble' or 'nord' without tilde."
  printf "\\n"
}

if [ "$#" -eq 0 ] ; then
  echo "$0: Argument required"
  echo
  usage
  exit 1
fi

while [ "$#" -gt 0 ] ; do
  case "$1" in
    -n | --name) name="$2" ; shift; shift;;
    -f | --file) filename="$2" ; shift; shift;;
    -t | --tmux) tmuxtheme="$2" ; shift; shift;;
    -h | --help)
      usage
      exit
      ;;
    *)
      printf "\\n%s\\n" "$0: Invalid argument $1"
      exit 1
      ;;
  esac
done

[ -z "$name" ] && die "No theme name, see -h | --help..."
[ -z "$filename" ] && die "No filename, see -h | --help..."
[ -z "$tmuxtheme" ] && die "No theme for tmux choosen, see -h | --help..."
[ -f "$filename" ] || die "File $filename do not exist."

case "$tmuxtheme" in
  'bubble')
    ;;
  'nord')
    ;;
  *)
    echo "bad theme for tmux, only bubble or nord"
    exit 1
    ;;
esac


echo "name $name"
CAPNAME=$(echo "$name" | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')
echo "cap name $CAPNAME"
echo "filename $filename"

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

# EXTRA colors
getjq_palette() {
  color=$(cat < "$filename" | jq "$1" | tr -d '"')
  echo "$color" | tr -d '"'
}

primaryLow=$(getjq_palette '.palettes.primary["70"]')
secondaryLow=$(getjq_palette '.palettes.secondary["70"]')
tertiaryLow=$(getjq_palette '.palettes.tertiary["70"]')

WORKDIR="/tmp/$name"
VIMLOAD="$WORKDIR/.vim/pack/dotfiles/start/vamp.vim/autoload"
VIMCOLOR="$WORKDIR/.vim/pack/dotfiles/start/vamp.vim/colors"

echo "Creating required directory at $WORKDIR..."
[ -d "$WORKDIR" ] && rm -r "$WORKDIR"
mkdir -p "$WORKDIR/.Xresources.d"
mkdir -p "$WORKDIR/.config/awesome/theme"
mkdir -p "$WORKDIR/.config/zathura"
mkdir -p "$WORKDIR/.tmux"
mkdir -p "$VIMLOAD/lightline/colorscheme"
mkdir -p "$VIMCOLOR"

echo "Grabbing a vim theme from Github..."
curl -sSL https://raw.githubusercontent.com/dracula/vim/master/colors/dracula.vim -o "$VIMCOLOR/$name.vim"
curl -sSL https://raw.githubusercontent.com/dracula/vim/master/autoload/lightline/colorscheme/dracula.vim -o "$VIMLOAD/lightline/colorscheme/$name.vim"

sed "s/dracula/$name/g" -i "$VIMLOAD/lightline/colorscheme/$name.vim"
sed "s/dracula/$name/g" -i "$VIMCOLOR/$name.vim"
sed "s/Dracula/$CAPNAME/g" -i "$VIMCOLOR/$name.vim"

echo "Generating Xresource..."
cat <<EOF > "$WORKDIR/.Xresources.d/fonts"
st.font: Iosevka Term:pixelsize=14:autohint=true;
EOF

cat <<EOF > "$WORKDIR/.Xresources.d/colors"
! Theme - background
*background: $background
*foreground: $onBackground
*cursorColor: $primary
*fadeColor: $surfaceContainerLow
! Black - surfaceContainer
*color0: $surfaceContainer
*color8: $surfaceContainerHigh
! Red - error
*color1: $error
*color9: $error
! Green - not include in Material, may be custom
*color2: $onSecondaryContainer
*color10: $onSecondaryContainer
! Yellow - tertiary
*color3: $tertiaryLow
*color11: $tertiary
! Blue - secondary
*color4: $secondaryLow
*color12: $secondary
! Magenta - primary
*color5: $primaryLow
*color13: $primary
! Cyan - not include in Material, may be custom
*color6: $secondaryFixedDim
*color14: $secondaryFixedDim
! White
*color7: $onSurface
*color15: $onPrimaryContainer
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
  name = '$name',
  wallpaper = os.getenv('HOME') .. '/images/' .. '$name.jpg',
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
theme.color.scrim = '$scrim'

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

# Base file:
# https://github.com/dracula/zathura/blob/master/zathurarc
echo "Generating zathura..."
cat <<EOF > "$WORKDIR/.config/zathura/zathurarc"
set font "Iosevka Term 10"
set default-bg "$background"
set default-fg "$onBackground"

set index-bg         "$background"         # Background
set index-fg         "$onBackground"       # Foreground
set index-active-bg  "$primaryContainer"   # Current Line
set index-active-fg  "$onPrimaryContainer" # Foreground

set statusbar-fg "$onBackground"
set statusbar-bg "$background"
set inputbar-fg "$onBackground"
set inputbar-bg "$background"

set notification-error-bg "$tertiary"
set notification-error-fg "$onTertiary"
set notification-warning-bg "$error"
set notification-warning-fg "$onError"
set notification-bg "$surfaceContainer"
set notification-fg "$onSurface"

set completion-highlight-bg "$secondaryContainer"   # Selection
set completion-highlight-fg "$onSecondaryContainer" # Fg

set recolor-lightcolor "$background"  # bg
set recolor-darkcolor "$onBackground" # fg

set recolor "true"
set adjust-open width
EOF

echo "Generating tmux..."
if [ "$tmuxtheme" = 'nord' ] ; then
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
fi

if [ "$tmuxtheme" = 'bubble' ] ; then
cat <<EOF > "$WORKDIR/.tmux/status"
COLOUR_BG="$background"
COLOR_PRIMARY="$primary"
COLOR_PRIMARY_CONTAINER="$primaryContainer"
COLOR_ON_PRIMARY_CONTAINER="$onPrimaryContainer"
COLOR_SURFACE="$surfaceContainerHighest"
COLOR_ON_SURFACE="$onSurface"
COLOR_TERTIARY="$tertiary"
COLOR_SECONDARY="$secondary"

set-option -g status-position bottom

setw -g window-status-format "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]#[fg=\$COLOR_SECONDARY,bg=\$COLOR_SURFACE] #I #[fg=\$COLOR_SECONDARY,bg=\$COLOR_SURFACE] #W #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]"

setw -g window-status-current-format "#[fg=\$COLOR_PRIMARY_CONTAINER,bg=\$COLOUR_BG]#[bg=\$COLOR_PRIMARY_CONTAINER]#[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #I #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #{pane_current_path} #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #W #[fg=\$COLOR_PRIMARY_CONTAINER,bg=\$COLOUR_BG]"

# FIRST ( 9 >> )
set -g status-left "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]#[fg=\$COLOR_ON_SURFACE,bg=\$COLOR_SURFACE] #S #[fg=\$COLOR_TERTIARY,bg=\$COLOR_SURFACE,nobold,nounderscore,noitalics]>> #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG] "

set -g status-right "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]#[fg=\$COLOR_PRIMARY,bg=\$COLOR_SURFACE]   #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]"

set -g status-justify left
set -g pane-active-border-style "fg=black,bg=default"
set -g status-style "fg=default,bg=default"

setw -g window-status-activity-style "fg=colour27,bg=colour234,none"
setw -g window-status-separator " "
setw -g window-status-style "fg=colour39,bg=colour234,none"
set -g pane-active-border-style "fg=\$COLOUR_BG" # hide border
set -g pane-border-style "fg=\$COLOUR_BG" # hide border
EOF
fi

echo "Generation vim..."
cat <<EOF > "$WORKDIR/.vim/colorscheme"
" Color
colorscheme $name

" Reload colorscheme
map <F8> :update<CR>:colorscheme $name<CR>
EOF

# Original file:
# https://raw.githubusercontent.com/dracula/vim/master/autoload/dracula.vim
cat <<EOF > "$VIMLOAD/$name.vim"
" Palette: {{{
let g:$name#palette           = {}
let g:$name#palette.fg        = ['$onBackground', 253] " #F8F8F2

let g:$name#palette.bglighter = ['$surfaceContainerHighest', 238]
let g:$name#palette.bglight   = ['$surfaceContainerHigh', 237]
let g:$name#palette.bg        = ['$surfaceContainer', 236]
let g:$name#palette.bgdark    = ['$surfaceContainerLow', 235] " #21222C
let g:$name#palette.bgdarker  = ['$surfaceContainerLowest', 234]

let g:$name#palette.comment   = ['$outline', 61] " #6272A4
let g:$name#palette.selection = ['$surfaceBright', 239] " #44475A'
let g:$name#palette.subtle    = ['$inverseOnSurface', 238] " #424450'

let g:$name#palette.cyan      = ['#8BE9FD', 117]
let g:$name#palette.green     = ['#50FA7B',  84]
let g:$name#palette.orange    = ['$tertiaryLow', 215]
let g:$name#palette.pink      = ['$primary', 212] " #FF79C6'
let g:$name#palette.purple    = ['$secondary', 141] " #BD93F9
let g:$name#palette.red       = ['$error', 203] " #FF5555
let g:$name#palette.yellow    = ['$tertiary', 228] " #F1FA8C

"
" ANSI
"
let g:$name#palette.color_0  = '$surfaceContainerLow' " '#21222C'
let g:$name#palette.color_1  = '$error' " #FF5555
let g:$name#palette.color_2  = '#50FA7B'
let g:$name#palette.color_3  = '$tertiaryLow'
let g:$name#palette.color_4  = '$secondaryLow' " '#BD93F9'
let g:$name#palette.color_5  = '$primaryLow' " '#FF79C6'
let g:$name#palette.color_6  = '#8BE9FD'
let g:$name#palette.color_7  = '$onBackground'
let g:$name#palette.color_8  = '$outline' " #6272A4
let g:$name#palette.color_9  = '$error' " '#FF6E6E'
let g:$name#palette.color_10 = '#69FF94'
let g:$name#palette.color_11 = '$tertiary' " '#FFFFA5'
let g:$name#palette.color_12 = '$secondary' " '#D6ACFF'
let g:$name#palette.color_13 = '$primary' " '#FF92DF'
let g:$name#palette.color_14 = '#A4FFFF'
let g:$name#palette.color_15 = '$onPrimaryContainer'
" }}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
EOF

cat <<EOF > "$WORKDIR/.vim/lightline-theme.vim"
let g:lightline.colorscheme = '$name'
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
