#!/usr/bin/env sh

set -o errexit

# https://www.baeldung.com/linux/jq-passing-bash-variables
# Lowered
#TODAY=$(date +%a | tr '[:upper:]' '[:lower:]')
#MONTH=$(date +%b | tr '[:upper:]' '[:lower:]')
HOUR=$(date +%k)
MINUTE=$(date +%M)
# return a Material Icon
ICON=""

if [ "$HOUR" -ge "7" ] && [ "$HOUR" -le "11" ] ; then
    #echo "MORNING - 11- "
    ICON=""
elif [ "$HOUR" -eq "12" ] ; then
    #echo "NOON - 12"
    ICON=""
elif [ "$HOUR" -ge "13" ] && [ "$HOUR" -le "17" ] ; then
    #echo "AFTERNOON - 13+"
    ICON=""
elif [ "$HOUR" -ge "18" ] && [ "$HOUR" -le "20" ] ; then
    ICON=""
elif [ "$HOUR" -ge "21" ] && [ "$HOUR" -le "23" ] ; then
    #echo "DUSk - 21+"
    ICON=""
elif [ "$HOUR" -eq "24" ] ; then
    #echo "MIDNIGHT 24"
    ICON=""
elif [ "$HOUR" -ge "1" ] && [ "$HOUR" -le "3" ] ; then
    #echo "WHITCH HOUR - 1-3"
    ICON=""
elif [ "$HOUR" -ge "4" ] && [ "$HOUR" -le "6" ] ; then
    #echo "MATIN HOUR - 4-6"
    ICON=""
fi

# Example is:
# jq '{"fruit": $ARGS.positional[0], "color": $ARGS.positional[1], "size": .size}' fruits_template.json --args $bash_fruit_var $bash_color_var
#
# Day
#if [ "$1" = "day" ] ; then
LL=$(echo '{"hour": "0", "min":"1", "icon": "2"}' | jq '{"hour": $ARGS.positional[0], "min": $ARGS.positional[1], "icon": $ARGS.positional[2]}' --args ${HOUR} ${MINUTE} ${ICON})
echo $LL
#fi

#if [ "$1" = "month" ] ; then
    # Month
#    LL=$(echo '{"month1": "0", "month2":"1", "month3": "2"}' | jq '{"month1": $ARGS.positional[0], "month2": $ARGS.positional[1], "month3": $ARGS.positional[2]}' --args ${MONTH:0:1} ${MONTH:1:1} ${MONTH:2:1})
#    echo $LL
#fi
