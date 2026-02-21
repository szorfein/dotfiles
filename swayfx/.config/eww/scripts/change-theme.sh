#!/usr/bin/env sh

set -o errexit -o nounset

ICON=""
DOTFILES="$HOME/.dotfiles"
THEMES="$DOTFILES/swayfx-themes"
FOUND=false
EWW_CONFIG="$HOME/.config/eww"

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

notify "$SELECTED installed, reloading...."

while :; do
    if eww ping -c "$EWW_CONFIG" > /dev/null; then
        echo "Reloading eww..."
        eww reload -c "$EWW_CONFIG" &
        wait
        break
    fi
    sleep 1
done

# Reload dunst
#dunstctl reload "$HOME/.config/dunst/dunstrc" 2> /dev/null || true
dunstctl reload

# Reload sway
swaymsg reload

# reload tmux conf
tmux source-file ~/.tmux.conf 2> /dev/null || true

# Neovim, complicated to reload plugin with lazy.nvim
#pkill -SIGUSR1 nvim

# Reload or kill...
~/bin/reload-terminal.sh

exit 0
