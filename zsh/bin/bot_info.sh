#!/bin/sh

set -e 

distro="gentoo"
theme="$(file ~/.config/awesome/loaded-theme.lua | grep -io "theme-[a-z]*" | sed s:theme-::g)"
wm='awesome'
res="$(xwininfo -root | grep geometry | awk '{print $2}' | cut -d + -f1)"
font=$(grep ^theme.myfont ~/.config/awesome/themes/$theme/theme.lua | sed s:theme.myfont::g | tr -d "=\"")

printf "\t" # align the colors
#█▓▒░ colors
i=0
while [ $i -le 6 ]
do
  printf "\e[$((i+41))m\e[$((i+30))m█▓▒░"
  i=$(($i+1))
done
printf "\e[37m█\e[0m▒░\n\n"

# Few colors
d=$'\e[1m' # bold
t=$'\e[0m' # end
red=$'\e[1;91m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
green=$'\e[1;92m'
dgreen=$'\e[1;32m'
white=$'\e[1;39m'

# colors for the display
logo=$magenta
title=$red
info=$white

function little_skull() {
cat << EOF
     $logo.-"|"-.$t   $title os    $info$distro$t
    $logo/ _   _ \\$t  $title theme $info$theme$t
    $logo](~  \`~)[$t  $title font$info$font$t
    $logo\`-. 0 ,-'$t  $title wm    $info$wm$t
    $logo  |...|$t    $title res   $info$res$t

 $title music >$t$info $(mpc|head -n1)
EOF
}
function big_skull() {
cat << EOF
  $logo####   ##### #####   ***#$t  $title os    $info$distro$t
  $logo###   X   #####   X   **#$t  $title theme $info$theme$t
  $logo####     ## # ##     ***#$t  $title font$info$font$t
  $logo########## ### ##*******#$t  $title wm    $info$wm$t
  $logo ### ############**# ###$t   $title res   $info$res$t
  $logo     ##-#-#-#-#-#-##$t
  $logo      | | | | | | |$t   $title music >$t$info $(mpc|head -n1)
EOF
}

function papilio() {
cat << EOF
                                         $logo.;;,$t
                     $logo.,.               .,;;;;;,$t
                    $logo;;;;;;;,,        ,;;%%%%%;;$t
                     $logo\`;;;%%%%;;,.  ,;;%%;;%%%;;$t
 $title os     $info$distro$t        $logo\`;%%;;%%%;;,;;%%%%%%%;;'$t
 $title wm     $info$wm$t          $logo\`;;%%;;%:,;%%%%%;;%%;;,$t
 $title res    $info$res$t           $logo\`;;%%%,;%%%%%%%%%;;;$t
 $title font $info$font$t          $logo\`;:%%%%%%;;%%;;;'$t
 $title theme  $info$theme$t                $logo.:::::::.$t
                                  $logo s.$t
EOF
}

function display_help() {
  echo "call $0 with -b or -l or -p"
  exit 0
}

case $1 in 
  -b | --big-skull) big_skull ; shift ;;
  -l | --little-skull) little_skull ; shift ;;
  -p | --papilio) papilio ; shift ;;
  -h | --help) display_help ; shift ;;
esac
#$title music >$t$info MASTER BOOT RECORD - Direct Memory Access
