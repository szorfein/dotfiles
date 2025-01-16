#!/usr/bin/env sh

set -o errexit

DATE=$(date '+%Y%m%d-%H%M%S')

grim ~/screenshot-$DATE.jpg
