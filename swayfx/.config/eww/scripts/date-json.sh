#!/usr/bin/env sh

set -o errexit

# https://www.baeldung.com/linux/jq-passing-bash-variables
# Lowered
#TODAY=$(date +%a | tr '[:upper:]' '[:lower:]')
#MONTH=$(date +%b | tr '[:upper:]' '[:lower:]')

# In caps
TODAY=$(date +%a | tr '[:lower:]' '[:upper:]')
MONTH=$(date +%b | tr '[:lower:]' '[:upper:]')

# Day
if [ "$1" = "day" ] ; then
    TODAY_1=$(expr "$TODAY" : "\\(.*\\)..")
    TODAY_2=$(expr "$TODAY" : ".\\(.*\\).")
    TODAY_3=$(expr "$TODAY" : "..\\(.*\\)")
    LL=$(echo '{"day1": "0", "day2":"1", "day3": "2"}' | jq '{"day1": $ARGS.positional[0], "day2": $ARGS.positional[1], "day3": $ARGS.positional[2]}' --args ${TODAY_1} ${TODAY_2} ${TODAY_3})
    echo $LL
fi

if [ "$1" = "month" ] ; then
    # Month
    MONTH_1=$(expr "$MONTH" : "\\(.*\\)..")
    MONTH_2=$(expr "$MONTH" : ".\\(.*\\).")
    MONTH_3=$(expr "$MONTH" : "..\\(.*\\)")
    LL=$(echo '{"month1": "0", "month2":"1", "month3": "2"}' | jq '{"month1": $ARGS.positional[0], "month2": $ARGS.positional[1], "month3": $ARGS.positional[2]}' --args ${MONTH_1} ${MONTH_2} ${MONTH_3})
    echo $LL
fi
