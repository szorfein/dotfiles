#!/usr/bin/env sh

set -o errexit

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.1"

if RET_JSON=$(curl -A "$UA" -sSL https://ipleak.net/json) ; then
    echo "$RET_JSON"
fi
