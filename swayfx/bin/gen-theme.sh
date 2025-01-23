#!/usr/bin/env sh

set -o errexit -o nounset

# Usage:
# gen-theme.sh ~/Downloads/magic.json magic
# Theme are generated on
# https://material-foundation.github.io/material-theme-builder/
# And exported in JSON format

filename="$1"
workdir="/tmp/$2"

# Clone this
# https://github.com/themix-project/oomox-gtk-theme
GTK_DIR="$HOME/labs/oomox-gtk-theme"

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
mkdir -p "$workdir/.config/nvim/lua"
mkdir -p "$workdir/.config/zathura"

# colours to extract
primary=$(ext_dark 'primary')
on_primary=$(ext_dark 'onPrimary')
primary_container=$(ext_dark 'primaryContainer')
on_primary_container=$(ext_dark 'onPrimaryContainer')
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
tertiary_container=$(ext_dark 'tertiaryContainer')
on_tertiary_container=$(ext_dark 'onTertiaryContainer')
error_container=$(ext_dark 'errorContainer')
on_error_container=$(ext_dark 'onErrorContainer')
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

cat <<EOF > "$workdir/.config/eww/colors.scss"
\$primary: $primary;
\$on-primary: $on_primary;
\$primary-container: $primary_container;
\$on-primary-container: $on_primary_container;
\$secondary: $secondary;
\$on-secondary: $on_secondary;
\$tertiary: $tertiary;
\$on-tertiary: $on_tertiary;
\$bg: $surface;
\$surface: $surface;
\$on-surface: $on_surface;
\$surface-container-low: $surface_container_low;
\$surface-container-high: $surface_container_high;
\$surface-container-highest: $surface_container_highest;
\$on-surface-variant: $on_surface_variant;
\$secondary-container: $secondary_container;
\$on-secondary-container: $on_secondary_container;
\$error: $error;
\$on-error: $on_error;
\$error-container: $error_container;
\$on-error-container: $on_error_container;
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
#set-option -s set-clipboard off
bind P paste-buffer
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe "wl-copy"
#bind-key -T copy-mode-vi V send-keys -X rectangle-toggle
#unbind -T copy-mode-vi Enter
#bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
#bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'wl-copy'
#bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'wl-copy'

# Configure plugin mode_indicator
set -g @mode_indicator_prefix_prompt "WAIT"
set -g @mode_indicator_prefix_mode_style fg=$secondary,bold
set -g @mode_indicator_copy_prompt "COPY"
set -g @mode_indicator_copy_mode_style fg=green,bold
set -g @mode_indicator_sync_prompt "SYNC"
set -g @mode_indicator_sync_mode_style fg=$error,bold
set -g @mode_indicator_empty_prompt "TMUX"
set -g @mode_indicator_empty_mode_style fg=purple,bold

# Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

# status line
set -gF status-style "bg=$surface,fg=$on_surface"

# Customize plugins colors
#
# App
set -gF @catppuccin_status_application_icon_bg "$surface_container_low"
set -g @catppuccin_status_application_icon_fg "$error"
set -gF @catppuccin_status_application_text_bg "$surface_container_low"
set -g @catppuccin_status_application_text_fg "$error"

# Session
set -gF @catppuccin_status_session_icon_bg "$surface_container_low"
set -gF @catppuccin_status_session_icon_fg "$tertiary"
set -gF @catppuccin_status_session_text_bg "$surface_container_low"
set -gF @catppuccin_status_session_text_fg "$tertiary"

# Uptime
set -gF @catppuccin_status_uptime_text_bg "$surface_container_low"
set -gF @catppuccin_status_uptime_text_fg "$secondary"
set -gF @catppuccin_status_uptime_icon_bg "$surface_container_low"
set -gF @catppuccin_status_uptime_icon_fg "$secondary"

# Directory
set -gF @catppuccin_status_directory_text_bg "$surface_container_low"
set -gF @catppuccin_status_directory_text_fg "$primary"
set -g @catppuccin_status_directory_icon_bg "$surface_container_low"
set -g @catppuccin_status_directory_icon_fg "$primary"

# Load catppuccin
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

# Current
set -g status-justify centre
set -gF window-status-format "#[bg=$surface_container_low,fg=$on_surface]##I:##T"
set -gF window-status-current-format "#[bg=$surface_container_low,fg=cyan,bold]##I:#[fg=cyan,bold]##T"

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-right ""
set -g status-left "#{tmux_mode_indicator}"
set -ag status-left "#{E:@catppuccin_status_application}"
set -ag status-left "#{E:@catppuccin_status_directory}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"

run-shell ~/.config/tmux/plugins/tmux-mode-indicator/mode_indicator.tmux
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

cat <<EOF > "$workdir/.config/zathura/zathurarc"
set default-fg                    "$on_surface"
set default-bg 			  "$surface"

set completion-bg		  "$surface_container_high"
set completion-fg		  "$on_surface"
set completion-highlight-bg	  "$primary_container"
set completion-highlight-fg	  "$on_primary_container"
set completion-group-bg		  "$surface_container_high"
set completion-group-fg		  "$secondary"

set statusbar-fg		  "$on_surface"
set statusbar-bg		  "$surface_container_high"

set notification-bg		  "$surface_container_high"
set notification-fg		  "$on_surface"
set notification-error-bg	  "$surface_container_high"
set notification-error-fg	  "$error"
set notification-warning-bg	  "$surface_container_high"
set notification-warning-fg	  "$tertiary"

set inputbar-fg			  "$on_surface"
set inputbar-bg 		  "$surface_container_high"

set recolor                       "true"
set recolor-lightcolor		  "$surface"
set recolor-darkcolor		  "$on_surface"

set index-fg		          "$on_surface"
set index-bg		          "$surface"
set index-active-fg	          "$on_surface"
set index-active-bg	          "$surface_container_high"

set render-loading-bg	          "$surface"
set render-loading-fg	          "$on_surface"

set highlight-color		  rgba(87,82,104,0.5)
set highlight-fg                  rgba(245,194,231,0.5)
set highlight-active-color	  rgba(245,194,231,0.5)
EOF

# Generate a gtk theme under ~/.themes
# need to remove '#' with ${MYVAR:1}
(cd "$GTK_DIR" && ./change_color.sh -o "$2" <(echo -e "BG=${surface:1}\nBTN_BG=${surface_container_high:1}\nBTN_FG=${primary:1}\nFG=${on_surface:1}\nGRADIENT=0.0\nHDR_BTN_BG=${primary:1}\nHDR_BTN_FG=${on_primary:1}\nHDR_BG=${surface_container_low:1}\nHDR_FG=${on_surface:1}\nROUNDNESS=24\nSEL_BG=${secondary_container:1}\nSEL_FG=${on_secondary_container:1}\nSPACING=8\nTXT_BG=${surface_container:1}\nTXT_FG=${on_surface:1}\nWM_BORDER_FOCUS=${primary:1}\nWM_BORDER_UNFOCUS=${outline:1}\n"))

# Load gtk theme with
# gsettings set org.gnome.desktop.interface gtk-theme "$2"

echo "$2 theme generated at $workdir"
