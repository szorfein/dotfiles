#! /bin/bash

##
# Here is a modified version of original script: 
# https://github.com/Andrwe/privoxy-blocklist/blob/master/privoxy-blocklist.sh

TMPDIR="/tmp/privoxy"
PRIVOXY_DIR="/etc/privoxy/"

# Look filter here https://easylist.to/pages/other-supplementary-filter-lists-and-easylist-variants.html
URLS=(
   #"https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_thirdparty.txt"
   #"https://easylist.to/malwaredomains_full.txt"
   "https://easylist.to/easylist/fanboy-annoyance.txt"
   "https://easylist.to/easylist/fanboy-social.txt"
   "https://easylist.to/easylist/easyprivacy.txt"
   "https://easylist.to/easylist/easylist.txt"
   "https://easylist-downloads.adblockplus.org/liste_fr.txt"
)

if [[ ! -d $TMPDIR ]] ; then
    echo "mkdir $TMPDIR"
    install -d -m700 $TMPDIR
fi

for url in ${URLS[@]}
do
    echo "Processing ${url} ...\n" || exit 0
    file=${TMPDIR}/$(basename ${url})
    actionfile=${file%\.*}.script.action
    filterfile=${file%\.*}.script.filter
    list=$(basename ${file%\.*})

    echo "Downloading ${url} ..." || exit 0
    wget -t 3 -O $file $url || exit 0
    echo ".. downloading done." || exit 0
    
    echo "Creating actionfile for $list" || exit 1
    echo -e "{ +block{${list}} }" > "${actionfile}"
    #sed '/^!.*/d;1,1 d;/^@@.*/d;/\$.*/d;/#/d;s/\./\\./g;s|?|\\?|g;s/\*/.*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/\^/[\/\&:\?=_]/g;s/^||/\./g;s/^|/^/g;s/|$/\$/g;/|/d' ${file} >> ${actionfile}
    sed '/^!.*/d;1,1 d;/^@@.*/d;/\$.*/d;/#/d;s/\./\\./g;s/\?/\\?/g;s/\*/.*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/\^/[\/\&:\?=_]/g;s/^||/\./g;s/^|/^/g;s/|$/\$/g;/|/d' ${file} >> ${actionfile}
    # below line from https://www.dd-wrt.com/phpBB2/viewtopic.php?t=276591&postdays=0&postorder=asc&start=90&sid=92245ff7817df7ec56cbda1b0b3f0862
    #sed '/^!.*/d;1,1 d;/^@@.*/d;/\$.*/d;/#/d;s/\./\\./g;s|?|\\?|g;s/\*/.*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/\^/[\/\&:\?=_]/g;s/^||/\./g;s/^|/^/g;s/|$/\$/g;/|/d' ${file} >> ${actionfile} 


    echo "actionfile -> $actionfile done"

    echo "Creating filterfile for $list..." || exit 1
    echo "FILTER: ${list} Tag filter of ${list}" > "${filterfile}"

    sed '/^#/!d;s/^##//g;s/^#\(.*\)\[.*\]\[.*\]*/s@<([a-zA-Z0-9]+)\\s+.*id=.?\1.*>.*<\/\\1>@@g/g;s/^#\(.*\)/s@<([a-zA-Z0-9]+)\\s+.*id=.?\1.*>.*<\/\\1>@@g/g;s/^\.\(.*\)/s@<([a-zA-Z0-9]+)\\s+.*class=.?\1.*>.*<\/\\1>@@g/g;s/^a\[\(.*\)\]/s@<a.*\1.*>.*<\/a>@@g/g;s/^\([a-zA-Z0-9]*\)\.\(.*\)\[.*\]\[.*\]*/s@<\1.*class=.?\2.*>.*<\/\1>@@g/g;s/^\([a-zA-Z0-9]*\)#\(.*\):.*[\:[^:]]*[^:]*/s@<\1.*id=.?\2.*>.*<\/\1>@@g/g;s/^\([a-zA-Z0-9]*\)#\(.*\)/s@<\1.*id=.?\2.*>.*<\/\1>@@g/g;s/^\[\([a-zA-Z]*\).=\(.*\)\]/s@\1^=\2>@@g/g;s/\^/[\/\&:\?=_]/g;s/\.\([a-zA-Z0-9]\)/\\.\1/g' ${file} >> ${filterfile}

    echo "{ +filter{${list}} }" >> "${actionfile}"
    echo "*" >> ${actionfile}
    echo "... filterfile added ..." || exit 1

    echo "{ -block }" >> ${actionfile}
    sed '/^@@.*/!d;s/^@@//g;/\$.*/d;/#/d;s/\./\\./g;s/\?/\\?/g;s/\*/.*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/\^/[\/\&:\?=_]/g;s/^||/\./g;s/^|/^/g;s/|$/\$/g;/|/d' ${file} >> ${actionfile}
    echo "{ -block +handle-as-image }" >> ${actionfile}
    sed '/^@@.*/!d;s/^@@//g;/\$.*image.*/!d;s/\$.*image.*//g;/#/d;s/\./\\./g;s/\?/\\?/g;s/\*/.*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/\^/[\/\&:\?=_]/g;s/^||/\./g;s/^|/^/g;s/|$/\$/g;/|/d' ${file} >> ${actionfile}

done

