#!/usr/bin/env sh

set -o errexit 

# https://gist.github.com/foxyfocus/4388f34059af56e179fb4aa00ca0a913

remove_escape_sequences() {
    tail -n +5 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g;/^\s*$/d"
}

get_interface() {
    if ! ip a | grep -q 'wl' ; then
        eww update wifi-on=false
        exit 1
    fi

    if interface=$(iwctl device list | remove_escape_sequences | awk '{print $1" == ["$2"] == ["$3"]"}' | awk '{print $1}') ; then
        #eww update wlan="$interface"
        #echo "$interface"
        eww update wifi-on=true
    else
        #eww update wlan=false
        #echo "false"
        eww update wifi-on=false
    fi
}

scan_ssid() {
    iwctl station "$interface" scan && sleep 1
    scan_result=$(iwctl station "$interface" get-networks | remove_escape_sequences | sed 's/\s\+/ /g')
    #| sed 's/ psk / ; [psk ] ; /;s/ open / ; [open] ; /;s/\s\+/ /g')
    #| awk -F " ; " '{print $2" =="$1}')
    #echo "$scan_result"
    str=$(echo "$scan_result" | jq -Rs | sed -e 's/\\n/", "/g' | sed -e 's/, ""//')
    #str=$(echo "$scan_result" | jq -Rs | sed -e 's/\\n/", "/g')
    #echo "$str"
    eww update wifi-ssids="[$str]"

    #iwctl station "$interface" connect "ssid"
    #iwctl station "$interface" disconnect
    #iwctl known-networks list
    #iwctl known-networks "network_name" show
}

get_interface
scan_ssid
