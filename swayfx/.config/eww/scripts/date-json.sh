#!/usr/bin/env sh

set -o errexit

# https://www.baeldung.com/linux/jq-passing-bash-variables
# Lowered
#TODAY=$(date +%a | tr '[:upper:]' '[:lower:]')
#MONTH=$(date +%b | tr '[:upper:]' '[:lower:]')

# In caps
TODAY=$(date +%a | tr '[:lower:]' '[:upper:]')
MONTH=$(date +%b | tr '[:lower:]' '[:upper:]')

# Example is:
# jq '{"fruit": $ARGS.positional[0], "color": $ARGS.positional[1], "size": .size}' fruits_template.json --args $bash_fruit_var $bash_color_var
#
# Day
if [ "$1" = "day" ] ; then
    LL=$(echo '{"day1": "0", "day2":"1", "day3": "2"}' | jq '{"day1": $ARGS.positional[0], "day2": $ARGS.positional[1], "day3": $ARGS.positional[2]}' --args ${TODAY:0:1} ${TODAY:1:1} ${TODAY:2:1})
    echo $LL
fi

if [ "$1" = "month" ] ; then
    # Month
    LL=$(echo '{"month1": "0", "month2":"1", "month3": "2"}' | jq '{"month1": $ARGS.positional[0], "month2": $ARGS.positional[1], "month3": $ARGS.positional[2]}' --args ${MONTH:0:1} ${MONTH:1:1} ${MONTH:2:1})
    echo $LL
fi
