#!/bin/bash

## SWAP! ##
# functions to give herbstluftwm some dynamic tiling behaviors.
# by Aaron "ninjaaron" Christianson <ninjaaron@gmail.com>

# Usage #
### auto
#    Swaps client in and out of "master" or "stack." If there is only one frame,
#    "auto" splits it. Example keybinding in herbstluftwm's autostart:
#        hc keybind $Mod-semicolon spawn /PATH/TO/swap auto
### stack_spawn
#    focuses stack and runs command. good wrapper for terminal:
#        hc keybind $Mod-period spawn /PATH/TO/swap stack_spawn xterm
### master_spawn
#    moves clients in master to stack and runs command. possible wrapper for
#    dmenu_run:
#        hc keybind $Mod-comma spawn /PATH/TO/swap master_spawn dmenu_run
### close
#    If client in master frame is closed, it is replaced by a client from the
#    stack. If stack is empty, it's removed. used like hlwm "close" command:
#        hc keybind $Mod-slash spawn /PATH/TO/swap close

# CONFIG #
# split_direction = frame split's orientation. "horizontal" or "vertical"
# split_ratio determines split's location. value between 0.1 and 0.9
# stack_layout = stack's hlwm layout. "horizontal" "vertical" "max" "grid"
# stack_frame = frame for stack. 0=top/left 1=bottom/right d=smaller frame
split_direction="horizontal"
split_ratio="0.6667" 
stack_layout="vertical" 
stack_frame=d 
# Here ends the section for users #

hc() { herbstclient $@;}; chn() { cmds="$cmds , $@";}
set_vars() { ### some vars need to be set more than once.
  dump=( $(hc dump) ) # put the content of hc dump into an array
  # values based directly on the dump
  Ratio=${dump[1]#*.} # make the division of primary frame an int
  Orientation=${dump[1]%%:*} # frames split horizontal or vertical
  Frame=${dump[1]##*:} # frame with active client 
  Empty0=${dump[3]: -1} # empty frames =')'; same for following 2 vars
  Empty1=${dump[${#dump[@]}-1]##*:};Empty1=${Empty1:1:1}
  EmptyAll=${dump[1]#*:};EmptyAll=${EmptyAll:1:1}
  # use absolute values from dump to determine values relative to stack/master.
  if [[ $stack_frame = "d" || "$split_direction" != "$Orientation" ]]
  then [ ${Ratio:0:1} -ge 5 ] && stack=1 || stack=0
  else  stack="${stack_frame:-1}"
  fi
  [ $Frame = "0" ] && emptyInact=$Empty1 || emptyInact=$Empty0
  if [[ $Orientation = "horizontal" && $stack = "1" ]]; then
    stackD=r; masterD=l; emptyStack="$Empty1"; emptyMaster="$Empty0"
  elif [[ $Orientation = "vertical" && $stack = "1" ]]; then
    stackD=d; masterD=u; emptyStack="$Empty1"; emptyMaster="$Empty0"
  elif [[ $Orientation = "horizontal" && $stack = "0" ]]; then
    stackD=l; masterD=r; emptyStack="$Empty0"; emptyMaster="$Empty1"
  elif [[ $Orientation = "vertical" && $stack = "0" ]]; then
    stackD=u; masterD=d; emptyStack="$Empty0"; emptyMaster="$Empty1"
  fi
  if [ $Frame = $stack ]
  then origin=$stackD; target=$masterD # $origin = active frame
  else origin=$masterD; target=$stackD # $target = inactive frame
  fi
}; set_vars # do all that stuff I just said

### functions called by the luser
auto() { ### swap out of the current frame into the other.
  if [ -n "$EmptyAll" ]; then # EmptyAll is null if 1 frame with clients exists.
    chn shift -e $target # move client to target frame.
    [ "$emptyInact" != ')' ] && 
    chn cycle -1 , shift -e $origin , focus -e $target , cycle 1
  else # one frame? split it. move client to new frame, set stack layout.
    hc split $split_direction $split_ratio; set_vars
    [ "$split_direction" = "horizontal" ]&&chn shift -e r || chn shift -e d
    chn focus -e $stackD , set_layout $stack_layout 
    [ $stack = 0 ] && chn focus -e $masterD
  fi; hc chain "$cmds"
}
stack_spawn() { ### spawn applications in the stack.
  [ "$EmptyAll" = ')' ] && $@ || # just spawn if no other clients exist.
    if [ -z "$EmptyAll" ]; then $@; auto; else hc focus -e $stackD; $@; fi
}
master_spawn() { ### spawn applications in the master.
  if [ "$EmptyAll" =  ')' ]
  then $@
  else # moves all the clients in master out and then spawn
    [ -z "$EmptyAll" ] && auto
    while [ "$emptyMaster" != ')' ]; do
      hc chain , focus -e $masterD , shift -e $stackD , focus -e $masterD
      set_vars
    done;"$@"
  fi
}
close() { ### replace master client on close. removes stack if empty.
  hc close; set_vars
  [ $emptyMaster = ')' ]&&
    hc chain , focus -e $stackD , shift -e $masterD&&set_vars
  [ $emptyStack = ')' ] && hc chain , focus -e $stackD , remove
}
$@;exit # do something and exit