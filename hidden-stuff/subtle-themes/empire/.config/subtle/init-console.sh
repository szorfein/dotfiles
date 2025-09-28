#!/bin/sh

TERM=$TERMINAL
LIST_PROC=(
    "weechat"
    "ncmpcpp"
    "mutt"
    "pwd"
    "cava"
)

clear_env() {
    local old_term=$(ps aux|egrep pwd|head -n1|awk '{print $2}')
    for i in ${LIST_PROC[@]} ; do
        echo "clear process $i"
        if [ $i == "pwd" ] ; then
            for p in $old_term ; do
                kill -9 $p
            done
        else
            for s in $(pgrep -u $UID -x $i) ; do
                kill -9 $s
            done
        fi
    done
}

launch_proc() {
    for i in ${LIST_PROC[@]} ; do
        echo "launch proc $i"
        if [ $i == "pwd" ]; then
            $TERM --name="$i" &
        else
            $TERM --name="$i" -e "$i" &
        fi
        sleep .4
    done
}

clear_env
trap "launch_proc" EXIT
