#!/usr/bin/env sh

set -o errexit

COLOR="$(grep container-low ~/.config/eww/styles/colors.scss | awk '{print $2}' | tr -d '#;')"

# Color use surfaceContainerLow
if [ -z $(swaymsg -t get_tree | grep '"app_id": "otter-launcher"') ]; then
    footclient --app-id "otter-launcher" -T "otter-launcher" -o "colors.background=$COLOR" -e sh -c "sleep 0.01 && otter-launcher"
else
    if [ -z $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).app_id' | grep "otter-launcher") ]; then
        swaymsg "[con_mark="otter-launcher"] scratchpad show; move position center"
    else
        swaymsg "[app_id="otter-launcher"] mark "otter-launcher"; move window scratchpad"
    fi
fi
