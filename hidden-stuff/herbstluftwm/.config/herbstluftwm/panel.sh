#! /bin/sh

source $(dirname $0)/config
monitor=${1:-0}
herbstclient pad $monitor ${HEIGHT} 11 ${HEIGHT} 11

set -f 

getName() {
    local icon=$(pIconUnderline ${WHITE} ${RED2} ${GENTOO})
    local cmd="$(uname -n)"
    local cmdEnd=$(pTextUnderline ${WHITE} ${RED} " ${cmd}")
    echo " ${icon}${cmdEnd}"
}

getMyIp() {
    local icon=$(pIcon ${YELLOW} ${CIP})
    local cmd="$(curl -s https://ifcfg.me/)"
    local cmdEnd=$(pText ${WHITE} "${cmd}")
    echo " ${icon} ${cmdEnd} ${icon}"
}

getDay() {
    local icon=$(pIconUnderline ${BLACK2} ${BLACK2} ${CTIME})
    local cmd=" $(date '+%A %d %b')" 
    local cmdEnd=$(pTextUnderline ${WHITE} ${BLACK} "${cmd}")
    echo "${icon}${cmdEnd}"
}

clock() {
    local icon=$(pIcon ${BLACK2} ${CCLOCK})
    local cmd=$(date +%H:%M)
    local cmdEnd=$(pText ${FG} "${cmd}")
    echo "${icon} ${cmdEnd}"
}

mail() {
    local gmaildir=/home/izsha/.mails/Gmail-Szorfein/\[Gmail\].All\ Mail/new
    local cmd=$(pAction ${BLACK2} ${BG} "herbstclient spawn termite -e mutt" ${CMAIL})
    local count=0
    if [[ ! -n $(ls "${gmaildir}") ]]; then
        count=0
    else
        count=$(ls -1 "${gmaildir}" | wc -l)
    fi
    echo "${cmd} ${count}"
}

energy() {
    local ac=/sys/class/power_supply/AC/online
    local bat=/sys/class/power_supply/BAT0/present
    local icon=""
    local batCap=""
    if [[ -e $bat ]] && [[ $(cat $ac) -lt 1 ]]; then
        batCap="$(cat ${bat%/*}/capacity)"
        [ $batCap -gt 90 ] && icon=$BAT100
        [ $batCap -gt 70 ] && [ $batCap -lt 90 ] && icon=$BAT70
        [ $batCap -gt 50 ] && [ $batCap -lt 70 ] && icon=$BAT50
        [ $batCap -gt 30 ] && [ $batCap -lt 50 ] && icon=$BAT30
        [ $batCap -gt 15 ] && [ $batCap -lt 30 ] && icon=$BAT15
        [ $batCap -lt 7 ] && icon=$BAT7
    elif [[ -n $(cat $ac) ]]; then
        batCap="AC"
        icon=$CAC
    else
        batCap="wttf"
    fi
    echo "$(pIcon ${BLACK2} $icon) $(pText "#685667" ${batCap})"
}

{
    while :; do
        wm=""
        TAGS=( $(herbstclient tag_status $monitor) )
        unset TAGS[${#TAGS[@]}]
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    FAG=${FG}
                    IC=${CFULL}
                    ;;
                '+') # active on other monitor
                    FAG=${WHITE}
                    IC=${CNONE}
                    ;;
                ':') # occupied
                    FAG=${FG}
                    IC=${CNONE}
                    ;;
                '!') # urgent tag
                    FAG=${YELLOW}
                    IC=${CFULL}
                    ;;
                *) # empty
                    FAG=${BLACK2}
                    IC=${CNONE}
                    ;;
            esac
            wm="$wm%{F$FAG} $(printf '%b' ${IC}) %{F-}"
        done
        echo "A${wm}"
        sleep 0.1 || break
    done &
    while :; do
        echo "W$(getName) $(getMyIp)"
        echo "R$(energy) $(mail) $(getDay) $(clock)"
        sleep 1 || break
    done &
}|{
    while read -r line ; do 
        cmd=( $line )
        case "${cmd[0]}" in
            W*)
                sysL="${line#?}"
                ;;
            A*)
                wm="${line#?}"
                ;;
            R*)
                sysR="${line#?}"
                ;;
            reload)
                exit
                ;;
            quit_panel)
                exit
                ;;
        esac
        printf "%s\n" "%{l}${sysL}%{c}${wm}%{r}${sysR}"
    done
}| lemonbar \
    -g x${HEIGHT} -u 2 -B ${BG} -F ${FG} -f "${FONT}" -f "${FONT_ICON}" &
wait 
