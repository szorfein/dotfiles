#!/usr/bin/env sh

set -o errexit

die() { echo "$1"; exit 1; }

usage() {
  printf "  %s\\t%s\\n" "-n, --name NAME" "A name for the new theme."
  printf "  %s\\t%s\\n" "-f, --file PATH" "A JSON file from a material theme."
  printf "  %s\\t%s\\n" "-t, --tmux THEME" "try: 'bubble' or 'nord' without tilde."
  printf "  %s\\t%s\\n" "-g, --green COLOR" "custom color for green e.g #50FA7B."
  printf "  %s\\t%s\\n" "-c, --cyan COLOR" "custom color for cyan e.g #8BE9FD."
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
    -g | --green) greencolor="$2" ; shift; shift;;
    -c | --cyan) cyancolor="$2" ; shift; shift;;
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
    iconleft=""
    iconright=""
    ;;
  'nord')
    iconleft=""
    iconright=""
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

[ -z "$greencolor" ] && greencolor="$secondaryFixedDim"
[ -z "$cyancolor" ] && cyancolor="$onPrimaryContainer"

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
st.font: IosevkaTerm Nerd Font:pixelsize=14:autohint=true;
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
*color2: $greencolor
*color10: $greencolor
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
*color6: $cyancolor
*color14: $cyancolor
! White
*color7: $onSurface
*color15: $onPrimaryContainer
EOF

echo "Generation awesome m3..."
cat <<EOF > "$WORKDIR/.config/awesome/theme/material.lua"
local fonts = require('lib.fonts')

local theme = {
  name = '$name',
  wallpaper = os.getenv('HOME') .. '/images/' .. '$name.jpg',
  color = {},
  typescale = fonts.iosevka()
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
theme.color.surface_container = '$surfaceContainer'
theme.color.outline_variant = '$outlineVariant'
theme.color.surface_container_low = '$surfaceContainerLow'
theme.color.surface_container_high = '$surfaceContainerHigh'

return theme
EOF

# Base file:
# https://github.com/dracula/zathura/blob/master/zathurarc
echo "Generating zathura..."
cat <<EOF > "$WORKDIR/.config/zathura/zathurarc"
set font "IosevkaTerm Nerd Font 10"
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
COLOR_PRIMARY_CONTAINER="$primaryContainer"
COLOR_ON_PRIMARY_CONTAINER="$onPrimaryContainer"
COLOR_SECONDARY_CONTAINER="$secondaryContainer"
COLOR_ON_SECONDARY_CONTAINER="$onSecondaryContainer"

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
set -g display-panes-colour "$surfaceContainer"
set -g display-panes-active-colour "$surfaceContainerHigh"

#+----------+
#+ Messages +
#+----------+
set -g message-style bg=$surfaceContainerHigh,fg=$primary
set -g message-command-style bg=$surfaceContainerHigh,fg=$primary

#+--------+
#+ Status +
#+--------+
#+ Bar ---+
set -g status-left "#[fg=\$COLOR_ON_SECONDARY_CONTAINER,bg=\$COLOR_SECONDARY_CONTAINER,bold] #S #[fg=\$COLOR_SECONDARY_CONTAINER,bg=#1F1F1F,nobold,noitalics,nounderscore]"

set -g status-right "#[fg=$surfaceContainerHigh,bg=$surfaceContainer,nobold,noitalics,nounderscore]#[fg=$onSurface,bg=$surfaceContainerHigh]#[fg=$onSurface,bg=$surfaceContainerHigh] ${TMUX_STATUS_TIME_FORMAT} #[fg=$primary,bg=$surfaceContainer,nobold,noitalics,nounderscore]#[fg=$background,bg=$primary,bold] #H "

#+ Window +
set -g window-status-format "#[fg=black,bg=brightblack,nobold,noitalics,nounderscore] #[fg=white,bg=brightblack]#I #[fg=white,bg=brightblack,nobold,noitalics,nounderscore] #[fg=white,bg=brightblack]#W #F #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=black,bg=\$COLOR_PRIMARY_CONTAINER,nobold,noitalics,nounderscore] #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER]#I #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER,nobold,noitalics,nounderscore] #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER]#W #F #[fg=\$COLOR_PRIMARY_CONTAINER,bg=black,nobold,noitalics,nounderscore]"
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

setw -g window-status-format "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconleft#[fg=\$COLOR_SECONDARY,bg=\$COLOR_SURFACE] #I #[fg=\$COLOR_SECONDARY,bg=\$COLOR_SURFACE] #W #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconright"

setw -g window-status-current-format "#[fg=\$COLOR_PRIMARY_CONTAINER,bg=\$COLOUR_BG]$iconleft#[bg=\$COLOR_PRIMARY_CONTAINER]#[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #I #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #{pane_current_path} #[fg=\$COLOR_ON_PRIMARY_CONTAINER,bg=\$COLOR_PRIMARY_CONTAINER] #W #[fg=\$COLOR_PRIMARY_CONTAINER,bg=\$COLOUR_BG]$iconright"

# FIRST ( 9 >> )
set -g status-left "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconleft#[fg=\$COLOR_ON_SURFACE,bg=\$COLOR_SURFACE] #S #[fg=\$COLOR_TERTIARY,bg=\$COLOR_SURFACE,nobold,nounderscore,noitalics]>> #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconright "

set -g status-right "#[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconleft#[fg=\$COLOR_PRIMARY,bg=\$COLOR_SURFACE]   #[fg=\$COLOR_SURFACE,bg=\$COLOUR_BG]$iconright"

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
# https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
cat <<EOF > "$VIMLOAD/$name.vim"
" Palette: {{{
let g:$name#palette           = {}
" Foreground
let g:$name#palette.fg        = ['$onBackground', 253] " #F8F8F2
let g:$name#palette.onprimarycontainer = ['$onPrimaryContainer', 250]
let g:$name#palette.onsecondarycontainer = ['$onSecondaryContainer', 248]
let g:$name#palette.ontertiarycontainer = ['$onTertiaryContainer', 248]
let g:$name#palette.onerrorcontainer = ['$onErrorContainer', 245]

" Background
let g:$name#palette.bglighter = ['$surfaceContainerHighest', 238]
let g:$name#palette.bglight   = ['$surfaceContainerHigh', 237]
let g:$name#palette.bg        = ['$surfaceContainerLow', 236]
let g:$name#palette.bgdark    = ['$background', 235] " #21222C
let g:$name#palette.bgdarker  = ['$surfaceContainerLowest', 234]
let g:$name#palette.primarycontainer = ['$primaryContainer', 110]
let g:$name#palette.secondarycontainer = ['$secondaryContainer', 92]
let g:$name#palette.tertiarycontainer = ['$tertiaryContainer', 92]
let g:$name#palette.errorcontainer = ['$errorContainer', 88]


let g:$name#palette.comment   = ['$outline', 61] " #6272A4
let g:$name#palette.selection = ['$surfaceBright', 239] " #44475A'
let g:$name#palette.subtle    = ['$inverseOnSurface', 238] " #424450'

let g:$name#palette.cyan      = ['$cyancolor', 117]
let g:$name#palette.green     = ['$greencolor',  84]
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
let g:$name#palette.color_2  = '$greencolor'
let g:$name#palette.color_3  = '$tertiaryLow'
let g:$name#palette.color_4  = '$secondaryLow' " '#BD93F9'
let g:$name#palette.color_5  = '$primaryLow' " '#FF79C6'
let g:$name#palette.color_6  = '$cyancolor'
let g:$name#palette.color_7  = '$onBackground'
let g:$name#palette.color_8  = '$outline' " #6272A4
let g:$name#palette.color_9  = '$error' " '#FF6E6E'
let g:$name#palette.color_10 = '$greencolor'
let g:$name#palette.color_11 = '$tertiary' " '#FFFFA5'
let g:$name#palette.color_12 = '$secondary' " '#D6ACFF'
let g:$name#palette.color_13 = '$primary' " '#FF92DF'
let g:$name#palette.color_14 = '$cyancolor'
let g:$name#palette.color_15 = '$onPrimaryContainer'
" }}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
EOF

cat <<EOF > "$VIMLOAD/lightline/colorscheme/$name.vim"
" =============================================================================
" Filename: autoload/lightline/colorscheme/$name.vim
" Author: szorfein based on adamalbrecht
" License: MIT License
" Last Change: 2018/04/11
" =============================================================================

let s:black    = g:$name#palette.bg
let s:gray     = g:$name#palette.bglight
let s:white    = g:$name#palette.fg
let s:blue     = g:$name#palette.secondarycontainer
let s:onblue   = g:$name#palette.onsecondarycontainer
let s:cyan     = g:$name#palette.cyan
let s:orange   = g:$name#palette.tertiarycontainer
let s:onorange = g:$name#palette.ontertiarycontainer
let s:purple   = g:$name#palette.primarycontainer
let s:onpurple = g:$name#palette.onprimarycontainer
let s:red      = g:$name#palette.errorcontainer
let s:onred    = g:$name#palette.onerrorcontainer
let s:yellow   = g:$name#palette.yellow

if exists('g:lightline')
  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
  let s:p.normal.left = [ [ s:onpurple, s:purple ], [ s:cyan, s:gray ] ]
  let s:p.normal.right = [ [ s:onpurple, s:purple ], [ s:onblue, s:blue ] ]
  let s:p.inactive.right = [ [ s:onblue, s:blue ], [ s:white, s:black ] ]
  let s:p.inactive.left =  [ [ s:cyan, s:black ], [ s:white, s:black ] ]
  let s:p.insert.left = [ [ s:onblue, s:blue ], [ s:cyan, s:gray ] ]
  let s:p.replace.left = [ [ s:onred, s:red ], [ s:cyan, s:gray ] ]
  let s:p.visual.left = [ [ s:onorange, s:orange ], [ s:cyan, s:gray ] ]
  let s:p.normal.middle = [ [ s:white, s:gray ] ]
  let s:p.inactive.middle = [ [ s:white, s:gray ] ]
  let s:p.tabline.left = [ [ s:onblue, s:blue ] ]
  let s:p.tabline.tabsel = [ [ s:cyan, s:black ] ]
  let s:p.tabline.middle = [ [ s:onblue, s:gray ] ]
  let s:p.tabline.right = copy(s:p.normal.right)
  let s:p.normal.error = [ [ s:onred, s:red ] ]
  let s:p.normal.warning = [ [ s:yellow, s:black ] ]

  let g:lightline#colorscheme#$name#palette = lightline#colorscheme#flatten(s:p)
endif

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
EOF

cat <<EOF > "$WORKDIR/.vim/lightline-theme.vim"
let g:lightline.colorscheme = '$name'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']] }

let g:lightline.separator = { 'right': '$iconleft', 'left': '$iconright' }
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
