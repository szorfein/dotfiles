#!/usr/bin/env sh

# https://linuxhandbook.com/find-command-exclude-directories/

set -o errexit

# Files pre-generated for FZF, FSEL
LIST_DIR="/tmp/list-directory"
LIST_FILES="/tmp/list-files"

list_dirs() {
    # List directory for Yazi (images, videos, musics, etc...)
    echo "Generate list for directory..."
    find "$HOME" -type d -not \( -name .cache -prune -o -name .bundle -prune -o -name node_modules -prune -o -name .npm -prune -o -name .git -prune -o -name BraveSoftware -prune -o -name .cargo -prune -o -name .gem -prune -o -name build -prune \) -print 2> /dev/null > "$LIST_DIR"
    echo "done with $LIST_DIR"
}

list_files() {
    # List of files to edit with Vim/Neovim/Emacs
    echo "Generate list for files to edit..."
    find "$HOME" -type f -regex '.*\.\(rs\|astro\|lua\|sh\|md\)' -not -path '*/.cache/*' -not -path '*/.python/*' -not -path '*/.cargo/*' -not -path '*/tmp/*' -not -path '*/.local/*' -print 2> /dev/null > "$LIST_FILES"
    echo "done with $LIST_FILES"
}

# Run every hour
while :; do
    list_dirs
    list_files
    sleep $((60 * 60))
done
