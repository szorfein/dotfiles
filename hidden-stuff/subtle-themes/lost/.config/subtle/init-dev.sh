#!/bin/sh

TERM=$TERMINAL
LIST_PROC=(
    "code-1"
)

clear_env() {
    local old_term=$(ps aux | grep -i "${TERM} --name=code" | awk '{print $2}')
    for i in ${old_term[@]} ; do
        echo "clear process $i"
        kill -9 $i
    done
}

launch_proc() {
    for i in ${LIST_PROC[@]} ; do
        echo "launch proc $i"
        $TERM --name="$i" &
        sleep .2
    done
}

clear_env
trap "launch_proc" EXIT
