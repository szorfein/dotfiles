#!/usr/bin/env sh

set -o errexit -o nounset

ICON=""
DOTFILES="$HOME/.dotfiles"
THEMES="$DOTFILES/swayfx-themes"
FOUND=false

die() {
    dunstify -u critical -a themes -i "$ICON" "Change theme" "$1" -r 988
    exit 1
}

notify() {
    dunstify -u normal -a themes -i "$ICON" "Change theme" "$1" -r 988
}

uninstall_theme() {
    stow -d "$THEMES" -D "$1" -t "$HOME"
}

install_theme() {
    stow -d "$THEMES" "$1" -t "$HOME"
}

#[ -n "$DOTFILES" ] || die "No var \$DOTFILES found in your shell"

[ -d "$DOTFILES" ] || die "No path $DOTFILES exist"
[ -n "$1" ] || die "need as parameter a theme-name"

SELECTED="$1"

for theme in "$THEMES"/*; do
    theme_name="${theme##*/}"
    if [ "$theme_name" = "$SELECTED" ]; then
        echo "found $SELECTED"
        FOUND=true
    fi
done

if ! "$FOUND"; then
    die "No theme $SELECTED found"
fi

for theme in "$THEMES"/*; do
    theme_name="${theme##*/}"
    echo "uninstall $theme_name"
    uninstall_theme "$theme_name"
done

install_theme "$SELECTED"

notify "$SELECTED installed."

sway reload &
wait

~/.config/eww/scripts/start.sh &
wait

exit 0
