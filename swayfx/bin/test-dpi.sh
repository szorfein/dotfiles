#!/usr/bin/env sh

set -o errexit

# https://www.kali.org/docs/general-use/fixing-dpi/
#
# You need to manually add your value
# swaymsg -t get_outputs
# Need install wlr-randr
# You need 3 values, width, height, diagonal 
# Width 1366
# Heigh 768
# Diagonal 11.6 (inch) (search on Google here with your computer model or screen (e.g W515tu screen)
# 
# You can calculate your diagonal simply:
# My diagonal make 29.5 cm, 295 mm. (295 / 25.4) = 11.6
#
# Calc Dp used by Google, ((in scss))
#
# My DPI is 135
# echo 'print( (((1366 ** 2)+(768 ** 2) ) ** (0.5) ) / 11.6 )' | python3 
# 135 (134.9)
# echo 'print( 135 / 160 ) | python3' # 0.8375
# My scale is 0.8375, so
# 1 px = 1 x 0.8375
#
# usage: ./test-dpi 1366 768 11.6
WIDTH="$1"
HEIGHT="$2"
DIAGONAL="$3"

to_shell() {
    echo "export EWW_SCALE=$1" > "$HOME/.eww_scale"
}

to_eww_scss() {
    ewwdir="$HOME/.config/eww"
    [ -d "$ewwdir" ] || mkdir -p "$ewwdir"
    echo "\$scale: $1;" > "$ewwdir/_scale.scss"
}

if [ -z "$WIDTH" ] || [ -z "$HEIGHT" ] || [ -z "$DIAGONAL" ] ; then
    echo "usage: ./test-dpi WIDTH HEIGHT DIAGONAL"
    echo "example: ./test-dpi 1366 768 11.6"
    echo "default use a scale of 1.0"
    to_shell "1.0"
    to_eww_scss "1.0"
    exit 0
fi

MYDPI=$(echo "print ( ((($WIDTH ** 2)+($HEIGHT ** 2) ) ** (0.5) ) / $DIAGONAL )" | python3)

DPC=$(echo "print( $MYDPI / 160 )" | python3)
echo "your DPI is $MYDPI"
echo "dp scale factor $DPC"

to_shell "$DPC"
to_eww_scss "$DPC"
