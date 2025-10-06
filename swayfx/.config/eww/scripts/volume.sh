#!/usr/bin/env sh

set -o errexit

ICON=""
ICON_INC=""
ICON_DEC=""
AUDIO="pulseaudio"

if pidof pipewire >/dev/null 2>&1; then
    AUDIO="pipewire"
elif ! pidof pulseaudio >/dev/null 2>&1; then
    AUDIO="alsa"
fi

noti() {
    dunstify -u low -i "$1" -a "volume" "Volume" "$2" -r 999
}

eww_update() {
    eww update volume="$1"
}

pipewire_get() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}' | tr -d '0.'
}

pipewire_set() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"%
    eww_update "$1"
    noti "$ICON" "wpctl set to $1"
}

pipewire_up() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    noti "$ICON_INC" "wpctl up"
}

pipewire_down() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    noti "$ICON_DEC" "wpctl decrease"
}

pipewire_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
}

get_pulseaudio() {
    pactl get-sink-volume @DEFAULT_AUDIO_SINK@
}

pulseaudio_set() {
    pactl set-sink-mute @DEFAULT_SINK@ false
    pactl set-sink-volume @DEFAULT_SINK@ "$1%"
    eww_update "$1"
    noti "$ICON" "pulse set to $1"
}

pulseaudio_get() {
    vol=$(pacmd list-sinks | grep "-" | grep -o " [0-9]*% " | head -n1)
    echo "$vol"
}

pulseaudio_up() {
    pactl set-sink-mute @DEFAULT_SINK@ false
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    noti "$ICON_INC" "pulse up"
}

pulseaudio_down() {
    pactl set-sink-mute @DEFAULT_SINK@ false
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    noti "$ICON_DEC" "pulse decrease"
}

pulseaudio_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

alsa_get() {
    vol=$(amixer sget Master | grep -o "[0-9]*%" | head -n 1 | tr -d '%')
    echo "$vol"
}

alsa_set() {
    amixer set Master "$1"% >/dev/null
    #eww_update "$1"
    noti "$ICON" "alsa set to $1"
}

alsa_up() {
    amixer set Master 5%+
    noti "$ICON_INC" "alsa up"
}

alsa_down() {
    amixer set Master 5%-
    noti "$ICON_DEC" "alsa decrease"
}

alsa_mute() {
    amixer set Master toggle
}

get_sound() {
    case "$AUDIO" in
        *pipewire*) pipewire_get ;;
        *pulseaudio*) pulseaudio_get ;;
        *alsa*) alsa_get ;;
    esac
}

set_sound() {
    case "$AUDIO" in
        *pipewire*) pipewire_set "$1" ;;
        *pulseaudio*) pulseaudio_set "$1" ;;
        *alsa*) alsa_set "$1" ;;
    esac
}

mute_sound() {
    case "$AUDIO" in
        *pipewire*) pipewire_mute ;;
        *pulseaudio*) pulseaudio_mute ;;
        *alsa*) alsa_mute ;;
    esac
}

up_sound() {
    case "$AUDIO" in
        *pipewire*) pipewire_up ;;
        *pulseaudio*) pulseaudio_up ;;
        *alsa*) alsa_up ;;
    esac
}

down_sound() {
    case "$AUDIO" in
        *pipewire*) pipewire_down ;;
        *pulseaudio*) pulseaudio_down ;;
        *alsa*) alsa_down ;;
    esac
}

if [ "$1" = "get" ] ; then 
    get_sound
fi

if [ "$1" = "set" ] ; then 
    set_sound "$2"
fi

if [ "$1" = "mute" ] ; then 
    mute_sound
fi

if [ "$1" = "up" ] ; then 
    up_sound
fi

if [ "$1" = "down" ] ; then 
    down_sound
fi

