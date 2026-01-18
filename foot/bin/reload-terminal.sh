#!/usr/bin/env sh

set -o errexit

pidof foot && pidof foot | xargs kill

# restart server
foot -s

exit 0
