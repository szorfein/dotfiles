#!/bin/sh

file=".config/awesome/loaded-theme.lua"
dotsdir="$(file ~/$file | awk '{print $5}')"
debug=false

awesomeThemes="miami morpho worker sci lines astronaut"
oldTheme=""
oldPath=""
dotfiles_dir=""
wantTheme=""

log() {
  if [ $debug == true ] ; then
    echo "$1"
  fi
}

die() {
  echo -e "[ERR] $1"
  exit 1
}

detect_theme() {
  log "call detect_theme"
  local t=""
  for theme in $awesomeThemes ; do
    if t=$(echo $dotsdir | grep $theme) ; then
      log "theme $theme : $t"
      oldTheme="$theme"
      oldPath="$t"
      break
    fi
  done
  [[ -z $t ]] && die "no theme $theme found..."
}

detect_dir() {
  log "call detect_dir"
  if [ -s "$HOME/$file" ] ; then
    log "A - link found $HOME/$file"
    log "A - dots dir $dotsdir"
  else
    die "no found link $link, are you use stow?"
  fi
}

split() {
  log "call split"
  local dots="$(echo $dotsdir | sed s:$file::g)"
  log "file - $file"
  log "dotsdir = $dotsdir"
  log "split - ${dots%/*/*}" # ../../labs/dotfiles
  dotfiles_dir=${dots%/*/*} # ../../labs/dotfiles"
  dotfiles_dir=$(echo "$dotfiles_dir" | sed s:^../..:$HOME:g)
}

change() {
  log "call change"
  log "operate - $dotfiles_dir"
  cd $dotfiles_dir
  stow -D $oldTheme -t ~
  stow $wantTheme -t ~
  xrdb -merge ~/.Xresources
  killall -USR1 xst # reload color from xst
  #awesome --replace
}

change_theme() {
  log "call change_theme"
  detect_dir
  detect_theme
  split
  change
  echo $wantTheme > /tmp/awesome-theme
}

while [ "$#" -gt 0 ] ; do
  case "$1" in
    -c | --change) wantTheme="$2" && trap change_theme EXIT
      shift ; shift ;;
    -d | --debug) debug=true ; shift ;;
    *) die "Unknown args $1, usage: $0 [--change] [theme-name]\nthemes available: $awesomeThemes" ;;
  esac
done

exit 0
