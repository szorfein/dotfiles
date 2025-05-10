#!/usr/bin/env sh

set -o errexit -o nounset

# Usage:
# gen-theme.sh ~/Downloads/magic.json magic
# Theme are generated on
# https://material-foundation.github.io/material-theme-builder/
# And exported in JSON format
# See my post https://szorfein.vercel.app/post/your-own-swayfx-theme

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

ext_terminal() {
  color=$(cat < "$filename" | jq .terminal."$1" | tr -d '"')
  echo "$color" | tr -d '"'
}

[ -d "$workdir" ] && rm -r "$workdir"

mkdir -p "$workdir"
mkdir -p "$workdir/.Xdefaults.d"
mkdir -p "$workdir/.config/sway"
mkdir -p "$workdir/.config/eww"
mkdir -p "$workdir/.config/wezterm"
mkdir -p "$workdir/.config/foot"
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
surface_variant=$(ext_dark 'surfaceVariant')
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
surface_bright=$(ext_dark 'surfaceBright')
# not include in dark theme
dark_primary=$(ext_palette 'primary.["60"]')
dark_secondary=$(ext_palette 'secondary.["60"]')
dark_tertiary=$(ext_palette 'tertiary.["60"]')
# extract terminal color
t_magenta_bright=$(ext_terminal 'magentaBright')
t_magenta=$(ext_terminal 'magenta')
t_red=$(ext_terminal 'red')
t_red_bright=$(ext_terminal 'redBright')
t_yellow=$(ext_terminal 'yellow')
t_yellow_bright=$(ext_terminal 'yellowBright')
t_green=$(ext_terminal 'green')
t_green_bright=$(ext_terminal 'greenBright')
t_cyan_bright=$(ext_terminal 'cyanBright')
t_cyan=$(ext_terminal 'cyan')
t_blue=$(ext_terminal 'blue')
t_blue_bright=$(ext_terminal 'blueBright')

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

cat <<EOF > "$workdir/.config/sway/theme"
set \$bg $surface
set \$fg $on_surface
set \$shadow $shadow
set \$outline $outline_variant
set \$bglight $background
set \$error $error
set \$theme $2
set \$theme-bg TODO: update-plz.jpg
EOF

cat <<EOF > "$workdir/.Xdefaults"
*background: $surface
*foreground: $on_surface
*cursorColor: $primary
*fadeColor: #1B1B1B
! Black - surfaceContainer
*color0: $surface_container
*color8: $surface_bright
! Red - error
*color1: $t_red
*color9: $t_red_bright
! Green
*color2: $t_green
*color10: $t_green_bright
! Yellow
*color3: $t_yellow
*color11: $t_yellow_bright
! Blue
*color4: $t_blue
*color12: $t_blue_bright
! Magenta
*color5: $t_magenta
*color13: $t_magenta_bright
! Cyan - not include in Material, may be custom
*color6: $t_cyan
*color14: $t_cyan_bright
! White
*color7: #E2E2E2
*color15: $on_surface
EOF

cat <<EOF > "$workdir/.config/wezterm/colors.lua"
return {
  -- The default text color
  foreground = '$on_surface',
  -- The default background color
  background = '$surface',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '$primary',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '$on_primary',
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
    '$surface_container_high', -- black
    '$t_red', -- red
    '$t_green', -- green
    '$t_yellow', -- yellow
    '$t_blue', -- blue
    '$t_magenta', -- magenta
    '$t_cyan', -- teal
    '#cbced3', -- white
  },
  brights = {
    '$surface_variant', -- black
    '$t_red_bright', -- red
    '$t_green_bright', -- green
    '$t_yellow_bright', -- yellow
    '$t_blue_bright', -- blue
    '$t_magenta_bright', -- magenta
    '$t_cyan_bright', -- teal
    '$on_surface', -- white
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#c296eb'
}
EOF

# need to remove '#' with ${MYVAR:1}
cat <<EOF > "$workdir/.config/foot/colors"
# -*- conf -*-
[cursor]

[colors]
# alpha=1.0
background=${surface:1}
foreground=${on_surface:1}
# flash=7f7f00
# flash-alpha=0.5

## Normal/regular colors (color palette 0-7)
regular0=${surface_container_high:1} # black
regular1=${t_red:1} # red
regular2=${t_green:1} # green
regular3=${t_yellow:1} # yellow
regular4=${t_blue:1} # blue
regular5=${t_magenta:1} # magenta
regular6=${t_cyan:1} # cyan
regular7=${on_surface:1} # white

## Bright colors (color palette 8-15)
bright0=${surface_variant:1} # bright black
bright1=${t_red_bright:1} # bright red
bright2=${t_green_bright:1} # bright green
bright3=${t_yellow_bright:1} # bright yellow
bright4=${t_blue_bright:1} # bright blue
bright5=${t_magenta_bright:1} # bright magenta
bright6=${t_cyan_bright:1} # bright cyan
bright7=${on_surface:1} # bright white

## dimmed colors (see foot.ini(5) man page)
# dim0=<not set>
# ...
# dim7=<not-set>

## The remaining 256-color palette
# 16 = <256-color palette #16>
# ...
# 255 = <256-color palette #255>

## Sixel colors
# sixel0 =  000000
# sixel1 =  3333cc
# sixel2 =  cc2121
# sixel3 =  33cc33
# sixel4 =  cc33cc
# sixel5 =  33cccc
# sixel6 =  cccc33
# sixel7 =  878787
# sixel8 =  424242
# sixel9 =  545499
# sixel10 = 994242
# sixel11 = 549954
# sixel12 = 995499
# sixel13 = 549999
# sixel14 = 999954
# sixel15 = cccccc

## Misc colors
# selection-foreground=<inverse foreground/background>
# selection-background=<inverse foreground/background>
# jump-labels=<regular0> <regular3>          # black-on-yellow
# scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
search-box-no-match=${error:1} ${on_error:1}  # black-on-red
# search-box-match=<regular0> <regular3>     # black-on-yellow
# urls=<regular3>
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
set -g @catppuccin_status_uptime_icon_bg "$surface_container_low"
set -g @catppuccin_status_uptime_icon_fg "$secondary"

# Directory
set -gF @catppuccin_status_directory_text_bg "$surface_container_low"
set -gF @catppuccin_status_directory_text_fg "$primary"
set -g @catppuccin_status_directory_icon_bg "$surface_container_low"
set -g @catppuccin_status_directory_icon_fg "$primary"

# Load catppuccin
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

# Current
set -g status-justify centre
set -gF window-status-format "#[bg=$surface_container_low,fg=$secondary_container]#[bg=$secondary_container,fg=$on_secondary_container]##I ##T#[bg=$surface_container_low,fg=$secondary_container]"
set -gF window-status-current-format "#[bg=$surface_container_low,fg=$primary]#[bg=$primary,fg=$on_primary,bold]##I #[fg=$on_primary,bold]##T#[bg=$surface_container_low,fg=$primary]"

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-right ""
set -g status-left "#{tmux_mode_indicator} "
set -ag status-left "#{E:@catppuccin_status_application}"
set -ag status-left "#{E:@catppuccin_status_directory}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"

run-shell ~/.config/tmux/plugins/tmux-mode-indicator/mode_indicator.tmux
EOF

# neovim
cat <<EOF > "$workdir/.config/nvim/lua/colors.lua"
-- theme $2
-- base colors: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
-- WGAG AAA need a contrast of 7:1 for normal text
return {
    --crust = '$surface_container_lowest',
    --surface1 = '$surface_container',
    --surface2 = '$surface_container_high'

    pink = "$t_magenta_bright", -- magenta light
    mauve = "$t_magenta", -- magenta
    red = "$t_red", -- red
    maroon = "$t_red_bright", -- red light
    peach = "$t_yellow", -- yellow
    yellow = "$t_yellow_bright", -- yellow light
    green = "$t_green", -- green
    teal = "$t_green_bright", -- green light
    sky = "$t_cyan_bright", -- cyan light
    sapphire = "$t_cyan", -- cyan
    blue = "$t_blue", -- blue
    lavender = "$t_blue_bright", -- blue light
    text = '$on_surface',

    --crust = '#0E0E13',
    mantle = '$surface_container_low',
    base = '$surface',
    surface0 = '$surface_container_highest',
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
