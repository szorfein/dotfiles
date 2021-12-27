#!/usr/bin/env bash

# New v2, new colors system (look colors from the theme-worker), remove rofi

# script to automatize boring things like edit all colors in all files
# who does not look the Xresource.
# manually launched when colors from the Xresource change

set -ue

XRE=~/.colors/color
ZRC=~/.config/zathura/zathurarc
KTY=~/.config/kitty/theme.conf
TMX=~/.tmux/status
CVA=~/.config/cava/config

die() { echo "$1"; exit 1; }
get_color() {
  tmp=$(grep "$1" $2 | head -n 1 | grep -io '#[a-z0-9A-Z]\{6\}$')
  [ -z "$tmp" ] && die "grep fail $1 $2"
  echo $tmp
  tmp=
}

# all colors (bg) by name
grey_dark=$(get_color theme0 $XRE)
grey=$(get_color "theme1 " $XRE)
grey_focus=$(get_color theme2 $XRE)
grey_light=$(get_color theme3 $XRE)
primary=$(get_color theme7 $XRE)
primary_light=$(get_color theme8 $XRE)
secondary=$(get_color theme9 $XRE)
secondary_light=$(get_color theme10 $XRE)
alert_dark=$(get_color theme11 $XRE)
alert=$(get_color theme12 $XRE)
alert_light=$(get_color theme13 $XRE)
alert_success=$(get_color theme14 $XRE)
alert_uncommon=$(get_color theme15 $XRE)

# all colors (fg) by name
fg_grey=$(get_color theme4 $XRE)
fg_grey_focus=$(get_color theme5 $XRE)
fg_grey_light=$(get_color theme6 $XRE)
fg_primary=$(get_color theme3 $XRE)
fg_primary_light=$(get_color "theme1 " $XRE)
fg_secondary=$(get_color theme3 $XRE)
fg_secondary_light=$(get_color "theme1 " $XRE)
fg_alert=$(get_color "theme1 " $XRE)

# check files
[ -s "$XRE" ] || die "no colors/color found"
[ -s "$ZRC" ] || die "no zathura/zathurarc found"
[ -s "$TMX" ] || die "no tmux/status found"
[ -s "$KTY" ] || die "no kitty/theme.conf found"
[ -s "$CVA" ] || die "no cava/config found"

apply_color() {
  str="$2" new="$3"
  old_line=$(grep "$str" $1 | head -n 1)
  [ -z "$old_line" ] && die "old_line is void - $0 called with args: $file , $str , $new"
  new_line=$(echo "$old_line" | sed "s:#[a-zA-Z0-9]\{6\}:$new:")
  [ -z "$new_line" ] && die "new_line is void - $0 called with args: $file , $str , $new"
  echo "apply s/$old_line/$new_line/ on $str to $1"
  sed --follow-symlinks -i "s/$old_line/$new_line/" $1
  [ $? -ne 0 ] && die "fail to apply s:$old_line:$new_line at $str on the file $1"
  old_line= new= str= new_line=
}

# zathura
apply_color $ZRC default-bg $grey
apply_color $ZRC default-fg $fg_grey
apply_color $ZRC statusbar-fg $fg_grey
apply_color $ZRC statusbar-bg $grey_dark
apply_color $ZRC inputbar-bg $primary
apply_color $ZRC inputbar-fg $fg_primary
apply_color $ZRC notification-error-bg $alert
apply_color $ZRC notification-error-fg $fg_alert
apply_color $ZRC notification-warning-bg $alert_light
apply_color $ZRC notification-warning-fg $fg_alert
apply_color $ZRC notification-bg $alert_dark
apply_color $ZRC notification-fg $fg_alert
apply_color $ZRC recolor-lightcolor $grey
apply_color $ZRC recolor-darkcolor $fg_grey

# Tmux
apply_color $TMX COLOUR_BG $grey_focus
apply_color $TMX PRIMARY $primary
apply_color $TMX FG_PRIMARY $fg_primary

# Kitty
apply_color $KTY background $grey
apply_color $KTY foreground $fg_grey
apply_color $KTY "color0 " $grey_focus
apply_color $KTY "color8 " $grey_light
apply_color $KTY "color1 " $alert_dark
apply_color $KTY "color9 " $alert
apply_color $KTY "color2 " $alert_success
apply_color $KTY color10 $alert_success
apply_color $KTY "color3 " $alert_light
apply_color $KTY color11 $alert_light
apply_color $KTY "color4 " $alert_uncommon
apply_color $KTY color12 $alert_uncommon
apply_color $KTY "color5 " $secondary
apply_color $KTY color13 $secondary_light
apply_color $KTY "color6 " $primary
apply_color $KTY color14 $primary_light
apply_color $KTY "color7 " $fg_grey
apply_color $KTY color15 $fg_grey_focus
apply_color $KTY cursor $fg_grey_focus

# cava
apply_color $CVA gradient_color_1 $primary
apply_color $CVA gradient_color_2 $primary_light

echo -e "\nbye"
exit 0
