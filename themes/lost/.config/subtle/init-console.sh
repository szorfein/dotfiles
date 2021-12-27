#!/bin/sh

TERM=$TERMINAL
LIST_PROC=(
    "weechat"
    "ncmpcpp"
    "cava"
    "mutt"
    "pwd"
)

clear_env() {
    local old_term=$(ps aux|egrep pwd|head -n1|awk '{print $2}')
    for i in ${LIST_PROC[@]} ; do
        echo "clear process $i"
        if [ $i == "pwd" ] ; then
            for p in $old_term ; do
                kill -9 $p 2>/dev/null 2>&1
            done
        else
            for s in $(pgrep -u $UID -x $i) ; do
                kill -9 $s 2>/dev/null 2>&1
            done
        fi
    done
    tmux kill-session -t mc 2>/dev/null
}

launch_proc() {
  $TERM --name="pwd" &
  $TERM --name="ncmpcpp" -e "ncmpcpp" &
  $TERM --name="cava" -e "cava" &
  $TERM --name="mutt" -e "tmux-mc" &
  sleep 4
}

clear_env
trap "launch_proc" EXIT
