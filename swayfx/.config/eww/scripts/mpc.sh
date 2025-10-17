#!/usr/bin/env sh

set -o errexit

load() {
    eww update playlist-focus="$1"
    mpc clear
    mpc load "$1"
    mpc play
}

update() {
    str=$(echo "[$(mpc lsplaylist | jq -Rs | sed -e 's/\\n/", "/g' | sed -e 's/, ""//')]")
    #str=$(echo "[$(mpc lsplaylist | jq -Rs | sed -e 's/\\n/", "/g')]")
    #echo "$str"
    eww update mpd-playlists="$str"
}

delete() {
    mpc rm "$1"
}

create() {
    mpc addplaylist "$1" "$(mpc -f %file% | head -1)"
}

if [ "$1" = "update" ]; then
    update
fi

if [ "$1" = "load" ]; then
    load "$2"
fi

if [ "$1" = "rm" ]; then
    delete "$2"
    update
fi

if [ "$1" = "create" ]; then
    create "$2"
    update
fi
