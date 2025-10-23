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
if [ "$1" = "day" ]; then
    TODAY_1=$(expr "$TODAY" : "\\(.*\\)..")
    TODAY_2=$(expr "$TODAY" : ".\\(.*\\).")
    TODAY_3=$(expr "$TODAY" : "..\\(.*\\)")
    cat << EOF
{"day1":"$TODAY_1","day2":"$TODAY_2","day3":"$TODAY_3"}
EOF
fi

if [ "$1" = "month" ]; then
    # Month
    MONTH_1=$(expr "$MONTH" : "\\(.*\\)..")
    MONTH_2=$(expr "$MONTH" : ".\\(.*\\).")
    MONTH_3=$(expr "$MONTH" : "..\\(.*\\)")
    cat << EOF
{"month1":"$MONTH_1","month2":"$MONTH_2","month3":"$MONTH_3"}
EOF
fi
