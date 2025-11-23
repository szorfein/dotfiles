#!/usr/bin/env bash

set -o errexit -o nounset

# Usage:
# gen-theme.sh ~/.material/theme.json magic
# Theme are generated on
# https://material-foundation.github.io/material-theme-builder/
# And exported in JSON format
# See my post https://szorfein.vercel.app/post/your-own-swayfx-theme
# Terminal colors can be generated from Aether:
# https://github.com/bjarneo/aether

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
mkdir -p "$workdir/.config/eww/styles"
mkdir -p "$workdir/.config/wezterm"
mkdir -p "$workdir/.config/foot"
mkdir -p "$workdir/.config/fsel"
mkdir -p "$workdir/.config/yazi"
mkdir -p "$workdir/.tmux"
mkdir -p "$workdir/.config/nvim/lua"
mkdir -p "$workdir/.config/zathura"
mkdir -p "$workdir/.config/dunst/dunstrc.d"
mkdir -p "$workdir/.config/gtk-3.0"
mkdir -p "$workdir/.config/gtk-4.0"

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
inverse_primary=$(ext_dark 'inversePrimary')
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
t_white=$(ext_terminal 'white')
t_white_bright=$(ext_terminal 'whiteBright')
t_black_bright=$(ext_terminal 'blackBright')

echo "primary $primary"
echo "secondary $secondary"

cat <<EOF > "$workdir/.config/eww/styles/typography.scss"
// material(3) use 2 fonts mainly and name it:
// md.ref.typeface.brand
// md.ref.typeface.plain
\$brand: 'Demova';
\$plain: 'Iosevka Nerd Font';

.display-large {
  font-family: \$brand;
  font-size: dpi(50pt);
  letter-spacing: dpi(-0.25pt);
  font-weight: 400;
}

.display-small {
  font-family: \$brand;
  font-size: dpi(46pt);
  letter-spacing: 0;
  font-weight: 400;
}

.headline-small {
  font-family: \$brand;
  font-size: dpi(54pt);
  font-weight: 400;
  letter-spacing: 0;
  color: \$on-surface;
}

// https://m3.material.io/styles/typography/type-scale-tokens

.title-small {
  font-family: \$plain;
  font-size: dpi(14pt);
  font-weight: 500;
  min-height: dpi(20pt);
  letter-spacing: dpi(0.1pt);
}

.body-large {
  font-family: \$plain;
  font-weight: 400;
  font-size: dpi(16pt);
  letter-spacing: dpi(0.5pt);
}

.body-medium {
  font-family: \$plain;
  font-weight: 400;
  font-size: dpi(14pt);
  min-height: dpi(20pt);
  // also named font-tracking
  letter-spacing: dpi(0.25pt);
  color: \$on-surface-variant;
}

.body-small {
  font-family: \$plain;
  font-weight: 400;
  font-size: dpi(12pt);
  min-height: dpi(16pt);
  // also named font-tracking
  letter-spacing: dpi(0.4pt);
}

.label-large {
  font-family: \$plain;
  font-size: dpi(14pt);
  font-weight: 500;
  letter-spacing: dpi(0.1pt);
  min-height: dpi(20px);
}

.label-medium {
  font-family: \$plain;
  font-size: dpi(12pt);
  font-weight: 500;
  letter-spacing: dpi(0.5pt);
  min-height: dpi(16px);
}
EOF

cat <<EOF > "$workdir/.config/eww/styles/colors.scss"
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
\$surface-container: $surface_container;
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
*color7: $t_white
*color15: $t_white_bright
EOF

cat <<EOF > "$workdir/.config/wezterm/colors.lua"
return {
  foreground = '$on_surface',
  background = '$surface',
  cursor_bg = '$primary',
  cursor_fg = '$on_primary',
  cursor_border = '#a5b6cf',
  selection_fg = '#a5b6cf',
  selection_bg = '#151720',
  scrollbar_thumb = '#11131c',
  split = '#0f111a',

  ansi = {
    '$surface_container_high', -- black
    '$t_red', -- red
    '$t_green', -- green
    '$t_yellow', -- yellow
    '$t_blue', -- blue
    '$t_magenta', -- magenta
    '$t_cyan', -- teal
    '$t_white', -- white
  },
  brights = {
    '$surface_variant', -- black
    '$t_red_bright', -- red
    '$t_green_bright', -- green
    '$t_yellow_bright', -- yellow
    '$t_blue_bright', -- blue
    '$t_magenta_bright', -- magenta
    '$t_cyan_bright', -- teal
    '$t_white_bright', -- white
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
regular7=${t_white:1} # white

## Bright colors (color palette 8-15)
bright0=${surface_variant:1} # bright black
bright1=${t_red_bright:1} # bright red
bright2=${t_green_bright:1} # bright green
bright3=${t_yellow_bright:1} # bright yellow
bright4=${t_blue_bright:1} # bright blue
bright5=${t_magenta_bright:1} # bright magenta
bright6=${t_cyan_bright:1} # bright cyan
bright7=${t_white_bright:1} # bright white

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
    rosewater = '$t_white_bright', -- white light
    flamingo = '$t_white', -- white
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
    --subtext1 = '#',
    --subtext0 = '#',
    overlay2 = '$t_black_bright',
    -- ...
    --surface2 = '$surface_container_high'
    --surface1 = '$surface_container',
    surface0 = '$surface_container_highest',
    base = '$surface',
    mantle = '$surface_container_low',
    --crust = '$surface_container_lowest',
    --crust = '#0E0E13', -- deep dark
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

# dunst
cat <<EOF > "$workdir/.config/dunst/dunstrc.d/10-bytheme.conf"
# To display terminal icon: (nerd-font, icomoon)
# echo "\u<code>", e.g: echo "\uf09c2"
[global]
    font = IosevkaTerm Nerd Font 14
    frame_width = 4
    frame_color = "$inverse_on_surface" # inverse-on-surface
    format = "<span rise='-5000' font_desc='Material Symbols Outlined Regular 20'>%I</span><span foreground='$inverse_on_surface'> %s</span><span font_desc='Iosevka Nerd Font Regular 14' foreground='$inverse_on_surface'> &gt; %b</span>"

[urgency_low]
    background = "$inverse_surface" # inverse-surface
    foreground = "$inverse_primary" # inverse-primary
    timeout = 5
    # Icon for notifications with low urgency
    default_icon = dialog-information

[urgency_normal]
    background = "$inverse_surface" # inverse-surface
    foreground = "$inverse_primary" # inverse-surface
    timeout = 5
    override_pause_level = 30
    # Icon for notifications with normal urgency
    default_icon = dialog-information

[urgency_critical]
    background = "$error"
    foreground = "$on_error"
    frame_color = "$error"
    timeout = 0
    override_pause_level = 60
    # Icon for notifications with critical urgency
    default_icon = dialog-warning

EOF

cat <<EOF > "$workdir/.config/fsel/config.toml"
cursor = "█"
terminal_launcher = "footclient -e"
# Don't wrap around at list ends (false = wrap around)
hard_stop = false
rounded_borders = true
# Highlight color for selected items and cursor
highlight_color = "$primary"      # Primary
# Border colors for each panel
main_border_color = "$surface_container_low"      # Border color for the main info panel (top)
apps_border_color = "$surface_container_low"      # Border color for the apps list panel (middle)
input_border_color = "$surface_container_low"     # Border color for the input panel (bottom)
# Text Colors (non-highlighted text in each panel)
main_text_color = "$on_surface"        # Text color for the main info panel
apps_text_color = "$on_surface"        # Text color for the apps list
input_text_color = "$on_surface"       # Text color for the input field
pin_color = "$tertiary"            # Color for pin icon (tertiary)
pin_icon = "📌"                  # Icon for pinned apps (use Ctrl+Space to pin/unpin)
header_title_color = "Magenta"   # Panel title color (Anything...)
fancy_mode = false # Show selected app name in titles (instead of "Apps"/"Fsel")
title_panel_height_percent = 30
input_panel_height = 3
title_panel_position = "top"

[app_launcher]
filter_desktop = true
list_executables_in_path = false
hide_before_typing = false
match_mode = "fuzzy"
confirm_first_launch = false

[dmenu]
delimiter = " "                  # Column delimiter (override with --delimiter)
show_line_numbers = true         # Show line numbers in content
wrap_long_lines = true           # Wrap long lines
password_character = "*"         # Character for --password mode
exit_if_empty = false            # Exit if stdin is empty

[cclip]
show_line_numbers = true         # Show cclip rowid
wrap_long_lines = true           # Wrap long lines
# Images (requires chafa + Kitty/Sixel terminal)
image_preview = true             # Show inline image previews
hide_inline_image_message = false # Hide "[Inline Image Preview]" text
EOF

cat <<EOF > "$workdir/.config/yazi/theme.toml"
[mgr]
hovered = { fg = "$on_primary", bg = "$primary" }
border_style = { fg = "black" }

# Mode are bottom left - right side
[mode]
normal_main = { bg = "$primary", fg = "$on_primary" }
normal_alt = { bg = "$tertiary", fg = "$on_tertiary" }

# Status bar
[status]
overall = { bg = "$surface_container_low", fg = "$on_surface" }

[filetype]
rules = [
# fallback - Dir
    { name = "*/", fg = "$secondary" }
]
EOF

cat <<EOF > "$workdir/.config/gtk-3.0/gtk.css"
/*
  Stolen on Aether
*/
@define-color background $surface;
@define-color foreground $on_surface;
@define-color black $surface;
@define-color red $t_red;
@define-color green $t_green;
@define-color yellow $t_yellow;
@define-color blue $t_blue;
@define-color magenta $t_magenta;
@define-color cyan $t_cyan;
@define-color white $t_white;
@define-color bright_black $t_black_bright;
@define-color bright_red $t_red_bright;
@define-color bright_green $t_green_bright;
@define-color bright_yellow $t_yellow_bright;
@define-color bright_blue $t_blue_bright;
@define-color bright_magenta $t_magenta_bright;
@define-color bright_cyan $t_cyan_bright;
@define-color bright_white $t_white_bright;

/* Adwaita Color Overrides */
@define-color accent_bg_color @blue;
@define-color accent_fg_color @background;
@define-color accent_color @cyan;
@define-color window_bg_color @background;
@define-color window_fg_color @foreground;

/* Sidebar background and content */
@define-color view_bg_color @black;
@define-color view_fg_color @foreground;
@define-color sidebar_bg_color @black;
@define-color sidebar_fg_color @foreground;
@define-color sidebar_backdrop_color @black;
@define-color sidebar_shade_color @black;
@define-color headerbar_bg_color alpha(@foreground, 0.1);
@define-color headerbar_fg_color @foreground;
@define-color headerbar_backdrop_color @black;
@define-color headerbar_shade_color @black;
@define-color card_bg_color alpha(@foreground, 0.1);
@define-color card_fg_color @foreground;
@define-color popover_bg_color @black;
@define-color popover_fg_color @foreground;
@define-color destructive_bg_color @red;
@define-color destructive_fg_color @background;
@define-color success_bg_color @green;
@define-color success_fg_color @background;
@define-color warning_bg_color @yellow;
@define-color warning_fg_color @background;
@define-color error_bg_color @red;
@define-color error_fg_color @background;
@define-color dialog_bg_color @background;
@define-color dialog_fg_color @foreground;
@define-color borders alpha(@foreground, 0.1);

/* GTK3 Adwaita Legacy Color Variables */
@define-color theme_fg_color @foreground;
@define-color theme_text_color @foreground;
@define-color theme_bg_color @background;
@define-color theme_base_color @black;
@define-color theme_selected_bg_color @blue;
@define-color theme_selected_fg_color @background;
@define-color insensitive_bg_color @background;
@define-color insensitive_fg_color @bright_black;
@define-color insensitive_base_color @black;
@define-color theme_unfocused_fg_color @foreground;
@define-color theme_unfocused_text_color @foreground;
@define-color theme_unfocused_bg_color @background;
@define-color theme_unfocused_base_color @black;
@define-color theme_unfocused_selected_bg_color @blue;
@define-color theme_unfocused_selected_fg_color @background;
@define-color unfocused_insensitive_color @bright_black;
@define-color unfocused_borders alpha(@foreground, 0.1);
@define-color warning_color @yellow;
@define-color error_color @red;
@define-color success_color @green;
@define-color destructive_color @red;

/* Content View Colors */
@define-color content_view_bg @black;
@define-color text_view_bg @black;

/* GtkMessageDialog styling */
/* Target the entire dialog's background */
messagedialog {
    background-color: @dialog_bg_color;
}

/* Target the main message label inside the dialog */
messagedialog label {
    color: @dialog_fg_color;
    font-size: 14pt;
    font-weight: bold;
}

/* Target the secondary, more detailed text (if any) */
messagedialog .secondary-text {
    font-size: 10pt;
    font-style: italic;
}

/* Target the buttons in the dialog's action area */
messagedialog button {
    background-color: @black;
    color: @foreground;
    border: 1px solid @bright_black;
    padding: 10px;
}

messagedialog button:hover {
    background-color: @blue;
}

banner revealer widget {
    background: @bright_black;
    padding: 5px;
    color: @foreground;
}

/* GtkAlertDialog styling */
alertdialog.background {
    background-color: @dialog_bg_color;
    color: @dialog_fg_color;
}

alertdialog .titlebar {
    background-color: @headerbar_bg_color;
    color: @headerbar_fg_color;
}

alertdialog box {
    background-color: @dialog_bg_color;
}

alertdialog label {
    color: @dialog_fg_color;
}

filechooser .dialog-action-box {
    border-top: 1px solid @bright_black;
}

filechooser .dialog-action-box:backdrop {
    border-top-color: @black;
}

filechooser #pathbarbox {
    border-bottom: 1px solid @bright_black;
}

filechooserbutton:drop(active) {
    box-shadow: none;
    border-color: transparent;
}

toast {
    background-color: @black;
    color: @foreground;
}

toast button.circular.flat.image-button:hover {
    color: @background;
    background-color: @red;
}

/* Sharp corners, Hyprland-inspired */
* {
    border-radius: 0;
}
EOF

# Copy the same config for gtk-4
cp "$workdir/.config/gtk-3.0/gtk.css" "$workdir/.config/gtk-4.0/gtk.css"

# Generate a gtk theme under ~/.themes
# need to remove '#' with ${MYVAR:1}
(cd "$GTK_DIR" && ./change_color.sh -o "$2" <(echo -e "BG=${surface:1}\nBTN_BG=${surface_container_high:1}\nBTN_FG=${primary:1}\nFG=${on_surface:1}\nGRADIENT=0.0\nHDR_BTN_BG=${primary:1}\nHDR_BTN_FG=${on_primary:1}\nHDR_BG=${surface_container_low:1}\nHDR_FG=${on_surface:1}\nROUNDNESS=24\nSEL_BG=${secondary_container:1}\nSEL_FG=${on_secondary_container:1}\nSPACING=8\nTXT_BG=${surface_container:1}\nTXT_FG=${on_surface:1}\nWM_BORDER_FOCUS=${primary:1}\nWM_BORDER_UNFOCUS=${outline:1}\n"))

# Load gtk theme with
# gsettings set org.gnome.desktop.interface gtk-theme "$2"

echo "$2 theme generated at $workdir"
