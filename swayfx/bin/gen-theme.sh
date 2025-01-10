#!/usr/bin/env sh

set -o errexit -o nounset

# Usage:
# gen-theme.sh ~/Downloads/magic.json magic

filename="$1"
workdir="/tmp/$2"

ext_dark() {
  color=$(cat < "$filename" | jq ".schemes.dark.$1" | tr -d '"')
  echo "$color" | tr -d '"'
}

ext_palette() {
  color=$(cat < "$filename" | jq .palettes."$1" | tr -d '"')
  echo "$color" | tr -d '"'
}

[ -d "$workdir" ] && rm -r "$workdir"

mkdir -p "$workdir"
mkdir -p "$workdir/.Xdefaults.d"
mkdir -p "$workdir/.config/custom"
mkdir -p "$workdir/.config/eww"
mkdir -p "$workdir/.config/wezterm"
mkdir -p "$workdir/.tmux"
mkdir -p "$workdir/.vim"
mkdir -p "$workdir/.config/nvim/lua"

# colours to extract
primary=$(ext_dark 'primary')
on_primary=$(ext_dark 'onPrimary')
secondary=$(ext_dark 'secondary')
on_secondary=$(ext_dark 'onSecondary')
tertiary=$(ext_dark 'tertiary')
on_tertiary=$(ext_dark 'onTertiary')
surface=$(ext_dark 'surface')
on_surface=$(ext_dark 'onSurface')
on_surface_variant=$(ext_dark 'onSurfaceVariant')
surface_tint=$(ext_dark 'surfaceTint')
inverse_surface=$(ext_dark 'inverseSurface')
inverse_on_surface=$(ext_dark 'inverseOnSurface')
# background is lighter than surface
background=$(ext_dark 'background')
secondary_container=$(ext_dark 'secondaryContainer')
on_secondary_container=$(ext_dark 'onSecondaryContainer')
error=$(ext_dark 'error')
on_error=$(ext_dark 'onError')
shadow=$(ext_dark 'shadow')
scrim=$(ext_dark 'scrim')
outline_variant=$(ext_dark 'outlineVariant')
outline=$(ext_dark 'outline')
surface_container_lowest=$(ext_dark 'surfaceContainerLowest')
surface_container_low=$(ext_dark 'surfaceContainerLow')
surface_container=$(ext_dark 'surfaceContainer')
surface_container_high=$(ext_dark 'surfaceContainerHigh')
surface_container_highest=$(ext_dark 'surfaceContainerHighest')
# not include in dark theme
dark_primary=$(ext_palette 'primary.["70"]')
dark_secondary=$(ext_palette 'secondary.["70"]')

echo "primary $primary"
echo "secondary $secondary"

cat <<EOF > "$workdir/.vim/colorscheme"
" Clipboard wayland
let g:wayland_clipboard_copy_args = ['--primary', '--paste-once']
nnoremap "+y y:call system("wl-copy", @")
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '', '', 'g')p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '', '', 'g')p
EOF

cat <<EOF > "$workdir/.config/eww/colors.scss"
\$primary: $primary;
\$on-primary: $on_primary;
\$secondary: $secondary;
\$on-secondary: $on_secondary;
\$tertiary: $tertiary;
\$on-tertiary: $on_tertiary;
\$bg: $surface;
\$surface: $surface;
\$on-surface: $on_surface;
\$surface-container-low: $surface_container_low;
\$surface-container-high: $surface_container_high;
\$on-surface-variant: $on_surface_variant;
\$secondary-container: $secondary_container;
\$on-secondary-container: $on_secondary_container;
\$error: $error;
\$on-error: $on_error;
\$outline: $outline;
\$outline-variant: $outline_variant;
\$scrim: $scrim;
\$shadow: $shadow;
\$surface-tint: $surface_tint;
\$inverse-surface: $inverse_surface;
\$inverse-on-surface: $inverse_on_surface;
EOF

cat <<EOF > "$workdir/.config/custom/sway"
set \$bg $surface
set \$fg $on_surface
set \$shadow $shadow
set \$outline $outline_variant
set \$bglight $background
set \$error $error
EOF

cat <<EOF > "$workdir/.Xdefaults"
*background: $surface
*foreground: $on_surface
*cursorColor: #DAB9FE
*fadeColor: #1B1B1B
! Black - surfaceContainer
*color0: $background
*color8: #2A2A2A
! Red - error
*color1: #FFB4AB
*color9: $error
! Green - not include in Material, may be custom
*color2: #3FA4C5
*color10: #88d0ed
! Yellow - tertiary
*color3: #FF8791
*color11: #FFB2B6
! Blue - secondary
*color4: $dark_secondary
*color12: $secondary
! Magenta - primary
*color5: $dark_primary
*color13: $primary
! Cyan - not include in Material, may be custom
*color6: #F86e9d
*color14: #ffb1c6
! White
*color7: #E2E2E2
*color15: #DDBEFF
EOF

cat <<EOF > "$workdir/.config/wezterm/colors.lua"
return {
  -- The default text color
  foreground = '$on_surface',
  -- The default background color
  background = '$surface',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#a5b6cf',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#0d0f18',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#a5b6cf',

  -- the foreground color of selected text
  selection_fg = '#a5b6cf',
  -- the background color of selected text
  selection_bg = '#151720',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#11131c',

  -- The color of the split lines between panes
  split = '#0f111a',

  ansi = {
    '$background', -- black
    '#dd6777', -- red
    '#90ceaa', -- green
    '#ecd3a0', -- yellow
    '$dark_secondary', -- blue
    '$dark_primary', -- magenta
    '#93cee9', -- teal
    '#cbced3', -- white
  },
  brights = {
    '#262831', -- black
    '$error', -- red
    '#95d3af', -- green
    '#f1d8a5', -- yellow
    '$secondary', -- blue
    '$primary', -- magenta
    '#98d3ee', -- teal
    '#d0d3d8', -- white
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#c296eb'
}
EOF

cat <<EOF > "$workdir/.tmux/status"
# Wayland clipboard
set -s copy-command 'wl-copy'

# clip vim
#bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy && wl-paste -n | wl-copy -p"
#bind-key p run "wl-paste -n | tmux load-buffer - ; tmux paste-buffer"
# Wayland, Ctrl+a+v (copy mode), press y for copy. Alt+p for paste
# https://www.rockyourcode.com/copy-and-paste-in-tmux/
set-option -s set-clipboard off
bind P paste-buffer
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X rectangle-toggle
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'wl-copy'
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'wl-copy'
EOF

# neovim
cat <<EOF > "$workdir/.config/nvim/lua/colors.lua"
-- theme $2
return {
  text = '$on_surface',
  --crust = '$surface_container_lowest',
  mantle = '$surface_container_low',
  base = '$surface',
  surface0 = '$surface_container_highest',
  --surface1 = '$surface_container',
  --surface2 = '$surface_container_high'
}
EOF

echo "$2 theme generated at $workdir"
