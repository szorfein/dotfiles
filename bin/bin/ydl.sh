#!/usr/bin/env bash

set -o errexit

# Script to download musics on youtube
# Dep: youtube-dl
# Usage e.g: ydl.sh https://youtu.be/1dAazZxw83Y?list=PLYaK2zRLpEbvjyUIqjroO5sVxugCRTH7c

LINK_MUSIC="$1"
WORKDIR="$HOME/mps"
OLDPATH="$(pwd)"
agentsList=(
    "Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201"
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"
)
RANDOM=$$$(date +%s)
rand=$[$RANDOM % ${#agentsList[@]}]
agent="${agentsList[$rand]}"

[ -d $WORKDIR ] || mkdir -p $WORKDIR

cd $WORKDIR
echo "Downloading $LINK_MUSIC..."
TOR_PORT=$(grep -i socksport /etc/tor/torrc | head -n 1 | awk '{print $2}')

  #--proxy "socks5://127.0.0.1:${TOR_PORT:-9050}" \
youtube-dl \
  --user-agent "$agent" \
  --add-metadata \
  -o '%(title)s/%(title)s.%(ext)s' \
  -f 'bestaudio' \
  --no-playlist \
  --write-thumbnail \
  -x --audio-format best \
  --audio-quality 0 "$LINK_MUSIC" || exit 1

echo "$LINK_MUSIC success"
cd $OLDPATH

exit 0
