#!/usr/bin/env sh

set -o errexit

DATE=$(date '+%Y%m%d-%H%M%S')

grim "$HOME/screenshot-$DATE.jpg"
