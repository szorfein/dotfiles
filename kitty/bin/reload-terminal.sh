#!/usr/bin/env sh

set -o errexit

if pgrep -f kitty 2> /dev/null; then
    # Reload kitty
    pkill -SIGUSR1 kitty
fi

exit 0
