#!/usr/bin/env sh

set -o errexit

DEBUG=false

# Search dotfiles
[ -d "$HOME/.dotfiles" ] && DOTFILES="$HOME/.dotfiles"

if [ -z "$DOTFILES" ] ; then
    [ -z "$DOTFILES_DIR"] && dagger "Dotfiles directory no found, use export DOTFILES_DIR=\"your_path\""
    DOTFILES="$DOTFILES_DIR"
fi

dagger() { echo "$1"; exit 1; }

del_stow() {
    [ $DEBUG = true ] && echo "Removing $2 from $1..."
    stow -d "$1" -D "$2" -t "$HOME"
}

add_stow() {
    echo "Adding $2 from $1..."
    stow -d "$1" "$2" -t "$HOME"
}

# from https://github.com/dylanaraps/pure-sh-bible
basename() {
    dir=${1%${1##*[!/]}}
    dir=${dir##*/}
    dir=${dir%"$2"}
    printf '%s\n' "${dir:-/}"
}

purge_stow() {
    echo "Uninstalling all dots from $DOTFILES..."

    for dir in .x awesomewm awm-m3 bin doomemacs gnupg mpd neovim ncmpcpp swayfx tmux vifm vim wezterm zsh; do
        [ -d "$DOTFILES/$dir" ] || continue
        del_stow "$DOTFILES" "$dir"
    done

    # swayfx material 3
    THEMES_DIR="$DOTFILES/swayfx-themes"
    for dir in $THEMES_DIR/*; do
        [ -d "$dir" ] || continue
        theme_dir=$(basename "$dir")
        del_stow "$THEMES_DIR" "$theme_dir"
    done

    # awesome material 3
    THEMES_DIR="$DOTFILES/themes-m3"
    for dir in $THEMES_DIR/*; do
        [ -d "$dir" ] || continue
        theme_dir=$(basename "$dir")
        del_stow "$THEMES_DIR" "$theme_dir"
    done

    # awesome material 2
    THEMES_DIR="$DOTFILES/themes"
    for dir in $THEMES_DIR/*; do
        [ -d "$dir" ] || continue
        theme_dir=$(basename "$dir")
        del_stow "$THEMES_DIR" "$theme_dir"
    done
}

#
# ncmpcpp
# swayfx-themes/holy
# swayfx
# tmux
# zsh
# neovim (soon)
#
usage() {
    echo "Arguments:"
    printf "\t%s\t\t\t\t%s\n"  "--purge" "Remove all older stow links, use it after each updates as first argument"
    printf "\t%s\t%s\n"  "-s | --swayfx theme-name" "Add swayfx with a theme-name (only 'holy' for now)"
    printf "\t%s\t%s\n"  "-a3 | --awm-m3 theme-name" "Add awesome-wm with a theme-name ('focus', 'connected', 'lines', 'miami', 'morpho', 'sci')"
    printf "\t%s\t%s\n"  "-a2 | --awm-m2 theme-name" "Add awesome-wm with old theme-name ('anonymous', 'astronaut', 'lines', 'machine', 'miami', 'morpho', 'worker') (! not sure all themes works !)"
    printf "\t%s\t\t%s\n"  "-d | --doomemacs" "Add dots for doomemacs"
    printf "\t%s\t\t\t%s\n"  "-nv | --neovim" "Add dots for neovim"
    printf "\t%s\t\t\t%s\n"  "-n | --ncmpcpp" "Add dots for ncmpcpp"
    printf "\t%s\t\t\t%s\n"  "-t | --tmux" "Add dots for tmux"
    printf "\t%s\t\t\t%s\n"  "-w | --wezterm" "Add dots for wezterm"
    printf "\t%s\t\t\t%s\n"  "-z | --zsh" "Add dots for zsh"
    printf "\t%s\t\t\t%s\n"  "-v | --vim" "Add dots for vim"
    printf "\nExamples:\n"
    echo 'stow.sh --purge --swayfx holy --tmux --neovim'
    echo 'stow.sh -p -s holy -t -nv'
}

# Argument are called in order of the command line
# so for example --wezterm
# should be colled before --swayfx holy
# --wezterm --swayfx holy
while [ "$#" -gt 0 ] ; do
    case "$1" in
        -n | --ncmpcpp)
            add_stow "$DOTFILES" "ncmpcpp"
            shift
            ;;
        -s | --swayfx)
            mkdir -p "$HOME/.config/sway"
            add_stow "$DOTFILES" "swayfx"
            add_stow "$DOTFILES/swayfx-themes" "$2"
            shift
            shift
            ;;
        -a3 | --awesome-m3)
            mkdir -p "$HOME/.config/awesome/theme"
            add_stow "$DOTFILES" ".x"
            add_stow "$DOTFILES" "awm-m3"
            add_stow "$DOTFILES/themes-m3" "$2"
            shift
            shift
            ;;
        -a2 | --awesome-m2)
            # Probably not working...
            # Also need to add themes/<theme-name> here
            mkdir -p "$HOME/.config/awesome/themes"
            mkdir -p "$HOME/.config/awesome/bar"
            add_stow "$DOTFILES" ".x"
            add_stow "$DOTFILES" "awesomewm"
            add_stow "$DOTFILES/themes" "$2"
            shift
            shift
            ;;
        -d | --doomemacs)
            add_stow "$DOTFILES" "doomemacs"
            shift
            ;;
        -nv | --neovim)
            mkdir -p "$HOME/.config/nvim/lua"
            add_stow "$DOTFILES" "neovim"
            shift
            ;;
        -t | --tmux)
            add_stow "$DOTFILES" "tmux"
            shift
            ;;
        -w | --wezterm)
            mkdir -p "$HOME/.config/wezterm"
            add_stow "$DOTFILES" "wezterm"
            shift
            ;;
        -z | --zsh)
            # Present on Voidlinux
            [ -f ~/.inputrc ] && rm ~/.inputrc
            add_stow "$DOTFILES" "zsh"
            shift
            ;;
        -v | --vim)
            add_stow "$DOTFILES" "vim"
            shift
            ;;
        -p | --purge)
            purge_stow
            shift
            ;;
        --debug)
            DEBUG=true
            shift
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            printf "\\n%s\\n" "$0: Invalid option '$1'"
            exit 1
    esac
done
