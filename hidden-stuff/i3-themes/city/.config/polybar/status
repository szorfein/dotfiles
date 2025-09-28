#!/bin/sh

set -e

daemon=${1:?}
state="%{F#e3313d}off%{F-}"
cmd="$(systemctl status $daemon | grep -i run 2>/dev/null || echo '')"

[[ "$cmd" ]] && state="%{F#a19c6c}on%{F-}"

echo "%{F#66818b}${daemon}%{F-} ${state}"
exit 0
