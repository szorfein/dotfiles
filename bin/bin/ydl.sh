#!/usr/bin/env bash

set -o errexit

# Script to download musics on youtube
# Dep: youtube-dl
# Usage e.g: ydl.sh https://youtu.be/1dAazZxw83Y?list=PLYaK2zRLpEbvjyUIqjroO5sVxugCRTH7c

LINK_MUSIC="$1"
WORKDIR="$HOME/mps"
OLDPATH="$(pwd)"
# https://www.useragents.me/
agentsList=(
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.1	31.36"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.3	25.19"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.3	17.78"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.3	5.93"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:132.0) Gecko/20100101 Firefox/132.	3.95"
)
RANDOM=$$$(date +%s)
rand=$(($RANDOM % ${#agentsList[@]}))
agent="${agentsList[$rand]}"

[ -d "$WORKDIR" ] || mkdir -p "$WORKDIR"

cd "$WORKDIR"
echo "Downloading $LINK_MUSIC..."

# TOR_PORT=$(grep -i socksport /etc/tor/torrc | head -n 1 | awk '{print $2}')

BIN="youtube-dl"

if command -v yt-dlp &>/dev/null ; then
  BIN="yt-dlp"
fi

  #--proxy "socks5://127.0.0.1:${TOR_PORT:-9050}" \
"$BIN" \
  --user-agent "$agent" \
  --add-metadata \
  -o '%(title)s/%(title)s.%(ext)s' \
  -f 'bestaudio' \
  --no-playlist \
  --write-thumbnail \
  --convert-thumbnail jpg \
  -x --audio-format best \
  --audio-quality 0 "$LINK_MUSIC"

echo "$LINK_MUSIC success"

cd "$OLDPATH"
