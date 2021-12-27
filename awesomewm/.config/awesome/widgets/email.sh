#!/bin/sh

count=0
log_file=/tmp/grab_email.log

die() {
  echo -e "[DIE]: $1"
  exit 1
}

check_grabber() {
  local offlineimap_bin=$(which /usr/bin/offlineimap)
  if [ -x $offlineimap_bin ] ; then
    $offlineimap_bin 2>/dev/null
    if [ $? -ne 0 ] ; then
      echo "$(date) - failed to get email" >> $log_file
    elif [ $? -eq 0 ] ; then
      echo "download wiith offlineimap"
    fi
  else
    echo "$(date) - $offlineimap_bin no found" >> $log_file
  fi
}

get() {
  check_grabber
  local mails_dir="$1"
  if [ -d $mails_dir ] ; then
    echo $(ls $mails_dir/*/INBOX/new | wc -l)
  else
    echo "$(date) - Directory $mails_dir no found..." >> $log_file
    die "path: $mails_dir no found"
  fi
}

show() {
  local mails_dir="$1" mails
  local mail_path="$mails_dir/*/INBOX/new/*"
  if [ -d $mails_dir ] ; then
    if mails="$(grep -i "^from" $mail_path 2>/dev/null | sort -u | sed -n -e 's/^.*From:/|/p')"; then
      if [ -z "$mails" ] ; then
        echo "No new mails from $mail_path"
      else
        echo "$mails" | tr -d "><"
      fi
    else
      echo "No mails found at $mails_dir"
      exit 0
    fi
  else
    die "path: $mails_dir no found"
  fi
}

case $1 in
  get)
    get "$2"
    shift
    shift 
    ;;
  show)
    show "$2"
    shift
    shift
    ;;
  *)
    die "arg: $1 not recognized\nArguments are [get,show] [mail_dir]"
esac

exit 0
