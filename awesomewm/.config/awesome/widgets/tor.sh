#!/bin/sh

## Require dependencies jq 
## Gentoo , app-misc/jq

check_tor() {
  local url
   url="https://check.torproject.org/"
  curl -s -m 10 -L "$url" | cat | tac | grep -q 'Congratulations'
  if [ $? -eq 0 ] ; then
    echo 0
  else
    echo 1
    exit 1
   fi
}

check_ip() {
  local infos
  if infos="$(curl -s -m 10 https://ipinfo.io)" || 
     infos="$(curl -s -m 10 https://ipapi.co/json)" ; then
       echo "$infos" | jq '.ip, .city, .region, .country, .hostname'
  else
    echo "no found..."
    exit 1
  fi
}

case "$1" in
  check) check_tor ;;
  ip) check_ip ;;
  *) echo "unknown arg $1" ; exit 1 ;;
esac

exit 0
