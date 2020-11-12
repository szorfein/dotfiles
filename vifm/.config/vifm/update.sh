#!/usr/bin/env sh

set -o errexit -o nounset

MBIN="$HOME"/labs/dotfiles/vifm/bin
MDIR="$HOME"/labs/dotfiles/vifm/.config/vifm

check_dir() {
  [ -d "$MBIN" ] || die "No $MBIN found"
  [ -d "$MDIR" ] || die "No $MDIR found"
}

# Src: https://github.com/cirala/vifmimg
vifmimg() {
  curl -L -o "$MBIN"/vifmimg https://raw.githubusercontent.com/cirala/vifmimg/master/vifmimg
  curl -L -o "$MBIN"/vifmrun https://raw.githubusercontent.com/cirala/vifmimg/master/vifmrun
  chmod 700 "$MBIN"/vifmimg
  chmod 700 "$MBIN"/vifmrun
}

main() {
  echo "updating vifm"
  check_dir
  vifmimg
  echo "done"
}

main
