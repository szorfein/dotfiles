#!/usr/bin/env sh

set -o errexit

theme_dir="$HOME/.dotfiles/awesome-m3-themes"
current_theme="/tmp/awm-m3"

[ -d "$theme_dir" ] || {
    echo "theme_dir ${theme_dir} no found."
    exit 1
}

[ -f "$current_theme" ] || {
    echo "no previous theme for m3 exist."
    exit 1
}

[ -z "$1" ] && {
    echo "no param."
    exit 1
}

old_theme=$(cat < "$current_theme")

search_theme() {
    [ -d "$theme_dir/$1" ] || {
        echo "theme $1 not exist in $theme_dir"
        exit 1
    }
}

change_theme() {
    cd "$theme_dir"
    stow -D "$1" -t "$HOME"
    stow "$2" -t "$HOME"
}

if [ "$old_theme" = "$1" ]; then
    echo "The both theme match, no need to change..."
    exit 1
fi

search_theme "$old_theme"
search_theme "$1"

change_theme "$old_theme" "$1"

hash xst 2> /dev/null && {
    xrdb merge ~/.Xresources
    if pid=$(pidof xst); then
        kill -s USR1 $pid
    fi
}

# if tmux
# https://stackoverflow.com/questions/18012930/how-can-i-redirect-all-output-to-dev-null
if command -v tmux 2> /dev/null; then
    tmux source ~/.tmux.conf 2> /dev/null &
fi
