#!/usr/bin/env bash

set -o errexit 

# colors: empty , focused , occupied , urgent
colors=("#9286E8" "#d1d1d1" "#81D6B1" "#AE6AE9")
files=("code.png" "web.png" "dev.png" "hack.png" "music.png" "chat.png" "reader.png" "draw.png" "vm.png" "game.png")
tags=9

die() { echo "[-] $1"; exit 1; }

for i in {1..10} ; do
  o=$(( i-1 ))
  [ -f ${files[$o]} ] || die "no found ${files[$o]}"
  convert "${files[$o]}" -alpha extract -background "${colors[0]}" -alpha shape "${i}_empty.png"
  echo "${files[$o]} to ${i}_empty.png $?"
  convert "${files[$o]}" -alpha extract -background "${colors[1]}" -alpha shape "${i}_focused.png"
  echo "${files[$o]} to ${i}_focused.png $?"
  convert "${files[$o]}" -alpha extract -background "${colors[2]}" -alpha shape "${i}_occupied.png"
  echo "${files[$o]} to ${i}_occupied.png $?"
  convert "${files[$o]}" -alpha extract -background "${colors[3]}" -alpha shape "${i}_urgent.png"
  echo "${files[$o]} to ${i}_urgent.png $?"
done

exit 0
