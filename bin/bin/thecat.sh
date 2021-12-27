f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

gtkrc="$HOME/.gtkrc-2.0"
GtkTheme=$( grep "gtk-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkIcon=$( grep "gtk-icon-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkFont=$( grep "gtk-font-name" "$gtkrc" | cut -d\" -f2 )

# Wallpaper set by feh
Wallpaper=$(cat ~/.fehbg | cut -c 16-70)

# Settings from ~/.Xdefaults
xdef="~/.Xdefaults"
TermFont="$(grep '^font' ~/.config/termite/config | awk '{print $3}')"

# Time and date
time=$( date "+%H.%M")
date=$( date "+%a %d %b" )

# OS
OS=$(uname -r)
dist=$(cat /etc/*-release | grep -i "^name" | sed 's/NAME=//g')
bit=$(uname -m)

# WM version
wm=$(grep "^exec" .xinitrc|awk '{print $2}')

# Other
UPT=`uptime | awk -F'( |,)' '{print $2}' | awk -F ":" '{print $1}'`
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
uptime2=$(uptime | sed -nr 's/.*\s+([[:digit:]]{1,2}):[[:digit:]]{2},.*/\1/p')
use=$(df | grep '^/dev/[hs]d' | awk -M '{s+=$3} END {printf("%.0f\n", s/1048576)}')
gb=$(echo "G")
pac=$(pacman -Qe | wc -l)
pacman=$(equery list "*" | wc -l)
COUNT=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)
cpu=$(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | cut -c13-40)
#laptop=$(dmidecode | grep Product)
lap1=$(cat /sys/class/dmi/id/sys_vendor)
lap2=$(cat /sys/class/dmi/id/product_name)

cat << EOF   
$bld                                           
$f7                                                  
$f7                    .c0N.   .'c.                  
$f7         'Okdl:'  ;OMMMMKOKNMMW:;o0l  .'.         $H the$f1 cat 
$f7         ;MMMMMMWWMMMMMMMMMMMMMMMMMXKWMMK         
$f7         'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK         $f6 $USER $f7@ $f1$HOSTNAME
$f7          NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO          
$f7          dMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:          GTK Theme »$f4 $GtkTheme$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM.          GTK Icons »$f4 $GtkIcon$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM;          GTK Font  »$f4 $GtkFont$NC
$f7          lMMMMM  MMMMMMMMMM  MMMMMMMMMM,          Term Font »$f4 $TermFont$NC
$f7          KMMMMM  MMMMMMMMMM  MMMMMMMMMM.          Packages  »$f2 $pacman
$f7         ;WMMMMMkNMMMMMMMMMMONMMMMMMMMMW:          
$f7       oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO         OS »$f4 $OS$NC
$f7      .,cxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMXdxo       $f7 WM »$f4 $wm  
$f7         ;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMM:         
$f7        .::,  .;ok0NMMMMWNK0kdoc;'  'cxK0          @  »$f7 $dist $bit
$f1                   .:cc:;;.                       
$f1                   .o0MMMK'                        
$f1                     xMMM:                         
$f1                     KMMMl                        $f2 $cpu
$f1                    .MMMMo                        $f3 $lap1 $lap2
$f1                    ,MMMMx                        
$f1                    oMMMMx                        
$f1                    OMMMMO                        $f7"And you can go fuck yourself, bitch"
$f1                    .OMMMd                                                     $f7 the$f1 cat     
$f1                      :Nl       

EOF
