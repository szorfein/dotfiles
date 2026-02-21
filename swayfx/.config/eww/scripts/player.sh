#!/usr/bin/env sh

set -o errexit

ICON="music_note"

if pgrep -f musics; then
    pgrep -f musics | xargs kill
fi

eww update playlist-focus="$1"

dunstify -a mpv -u low -i "$ICON" Playing "$1" -r 324

mpv --no-video --shuffle --profile=fast --script=/etc/mpv/scripts/mpris.so "$HOME/musics/$1"
