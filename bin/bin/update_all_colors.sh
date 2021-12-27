#!/usr/bin/env bash

# script to automatize boring things like edit all colors in all files
# who does not look the Xresource.
# manually launched when colors from the Xresource change

set -ue

XRE=~/.colors/color
ZRC=~/.config/zathura/zathurarc
RFI=~/.config/rofi/colors.rasi
KTY=~/.config/kitty/theme.conf
TMX=~/.tmux/status
CVA=~/.config/cava/config

die() { echo "$1"; exit 1; }
get_color() {
  tmp=$(grep "$1" $2 | head -n 1 | grep -io '#[a-z0-9A-Z]\{6\}')
  [ -z "$tmp" ] && die "grep fail $1 $2"
  echo $tmp
  tmp=
}

# all colors (bg) by name
grey_dark=$(get_color "no place" $XRE)
grey=$(get_color background $XRE)
grey_light=$(get_color color0: $XRE)
primary_dark=$(get_color color6: $XRE)
primary=$(get_color color2: $XRE)
primary_light=$(get_color color14: $XRE)
secondary_dark=$(get_color color5: $XRE)
secondary=$(get_color color4: $XRE)
secondary_light=$(get_color color13: $XRE)
alert_dark=$(get_color color1: $XRE)
alert=$(get_color color9: $XRE)
alert_light=$(get_color color3: $XRE)

# all colors (fg) by name
grey_fg_dark=$(get_color color8 $XRE)
grey_fg_light=$(get_color foreground $XRE)
primary_fg_dark=$(get_color color10 $XRE)
primary_fg_light=$(get_color color7 $XRE)
secondary_fg_dark=$(get_color color12 $XRE)
secondary_fg_light=$(get_color color15 $XRE)
alert_fg=$(get_color color11 $XRE)

# check files
[ -s "$XRE" ] || die "no colors/color found"
[ -s "$ZRC" ] || die "no zathura/zathurarc found"
[ -s "$RFI" ] || die "no rofi/colors.rasi found"
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
apply_color $ZRC default-fg $grey_fg_light
apply_color $ZRC statusbar-fg $grey_fg_dark
apply_color $ZRC statusbar-bg $grey_dark
apply_color $ZRC inputbar-bg $primary_dark
apply_color $ZRC inputbar-fg $primary_fg_dark
apply_color $ZRC notification-error-bg $alert
apply_color $ZRC notification-error-fg $alert_fg
apply_color $ZRC notification-warning-bg $alert_light
apply_color $ZRC notification-warning-fg $alert_fg
apply_color $ZRC notification-bg $alert_dark
apply_color $ZRC notification-fg $alert_fg
apply_color $ZRC recolor-lightcolor $grey
apply_color $ZRC recolor-darkcolor $grey_fg_light

# Rofi
apply_color $RFI xbg: $grey
apply_color $RFI xfg: $grey_fg_light
apply_color $RFI x0: $grey_light
apply_color $RFI x1: $alert_dark
apply_color $RFI x2: $primary
apply_color $RFI x3: $alert_light
apply_color $RFI x4: $secondary
apply_color $RFI x5: $secondary_dark
apply_color $RFI x6: $primary_dark
apply_color $RFI x7: $primary_fg_light
apply_color $RFI x8: $grey_fg_dark
apply_color $RFI x9: $alert
apply_color $RFI x10: $primary_fg_dark
apply_color $RFI x11: $alert_fg
apply_color $RFI x12: $secondary_fg_dark
apply_color $RFI x13: $secondary_light
apply_color $RFI x14: $primary_light
apply_color $RFI x15: $secondary_fg_light

# Tmux
apply_color $TMX COLOUR_BG $grey_dark

# Kitty
apply_color $KTY background $grey
apply_color $KTY "color0 " $grey_light
apply_color $KTY "color6 " $primary_dark
apply_color $KTY "color2 " $primary
apply_color $KTY color14 $primary_light
apply_color $KTY "color5 " $secondary_dark
apply_color $KTY "color4 " $secondary
apply_color $KTY color13 $secondary_light
apply_color $KTY "color1 " $alert_dark
apply_color $KTY "color9 " $alert
apply_color $KTY "color3 " $alert_light
apply_color $KTY "color8 " $grey_fg_dark
apply_color $KTY foreground $grey_fg_light
apply_color $KTY color10 $primary_fg_dark
apply_color $KTY "color7 " $primary_fg_light
apply_color $KTY color12 $secondary_fg_dark
apply_color $KTY color15 $secondary_fg_light
apply_color $KTY color11 $alert_fg
apply_color $KTY cursor $grey_fg_dark

# cava
apply_color $CVA gradient_color_1 $primary_dark
apply_color $CVA gradient_color_2 $primary_light

echo -e "\nbye"
exit 0
