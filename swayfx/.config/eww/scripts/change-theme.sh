#!/usr/bin/env sh

set -o errexit -o nounset

ICON=""
DOTFILES="$HOME/.dotfiles"
THEMES="$DOTFILES/swayfx-themes"
FOUND=false
#DUNST_CONFIG="$HOME/.config/dunst/dunstrc"
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

notify "$SELECTED installed, reloading...."

#eww close changetheme
#eww active-windows | grep changetheme$ | xargs eww close

if eww ping -c "$EWW_CONFIG" > /dev/null; then
    echo "reloading eww..."
    eww reload -c "$EWW_CONFIG" &
    wait
fi

#~/.config/eww/scripts/start.sh &
#wait

echo "dunst ?"
#dunstctl reload "$DUNST_CONFIG" 2> /dev/null || true
#pidof dunst | xargs kill
#dunst &
# Reload dunst
dunstctl reload

# Reload sway
swaymsg reload

# reload tmux conf
#tmux source-file ~/.tmux.conf 2> /dev/null || true
tmux source-file ~/.tmux.conf

# Neovim, complicated to reload plugin with lazy.nvim
#pkill -SIGUSR1 nvim

# unfortunately, this kill all open terminals, hopefully we use tmux
# Solution is to replace 'foot' by 'kitty' here
# tmux attach -t 0
pidof foot | xargs kill
foot -s &
#kill -s SIGUSR1 $(pidof footclient)

exit 0
