#!/usr/bin/env bash

set -o errexit 

SCAN_RES=""

# https://gist.github.com/foxyfocus/4388f34059af56e179fb4aa00ca0a913

if PIDS=$(pgrep -f "sh .*iwd.sh") ; then 
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ] ; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

remove_escape_sequences() {
    tail -n +5 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g;/^\s*$/d"
}

get_interface() {
    if ! ip a | grep -q 'wl' ; then
        eww update wifi-on=false
        return 1
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

    return 0
}

check_assoc() {
    capture_symbol=$(echo "$1" | awk '{print $1}')
    if [ "$capture_symbol" = ">" ] ; then
        return 0
    fi 
    return 1
}

build_json() {
    json='['
    while read -r line; do 
        #echo "[$line]"
        connected=false
        check_assoc "$line" && connected=true
        name=$(echo "$line" | tr -d '>' | awk '{print $1}')
        json+="{\"name\": \"$name\","
        json+="\"connected\": $connected},"
    done <<< "$SCAN_RES"
    json=${json::-1} # Remove last comma
    json+=']'
    #echo "$json"
    eww update wifi-ssids="$json"
}

scan_ssid() {
    iwctl station "$interface" scan
    sleep 1
    if ! SCAN_RES=$(iwctl station "$interface" get-networks | remove_escape_sequences | sed 's/\s\+/ /g') ; then
        return 0
    fi
    build_json
    #| sed 's/ psk / ; [psk ] ; /;s/ open / ; [open] ; /;s/\s\+/ /g')
    #| awk -F " ; " '{print $2" =="$1}')
    #echo "$scan_result"
    #str=$(echo "$scan_result" | jq -Rs | sed -e 's/\\n/", "/g' | sed -e 's/, ""//')
    #str=$(echo "$scan_result" | jq -Rs | sed -e 's/\\n/", "/g')
    #echo "$str"
    #eww update wifi-ssids="[$str]"

    #iwctl station "$interface" connect "ssid"
    #iwctl station "$interface" disconnect
    #iwctl known-networks list
    #iwctl known-networks "network_name" show
}

i=1
while :; do
    echo "run daemons/iwd $i"
    if get_interface ; then
        scan_ssid
    fi
    sleep 60
    i=$((i + 1))
done
