#!/bin/ksh

mkdir PICS
>./PICS/.list

wget $@ -O index.html

grep -o 'src="[^*]*"' *.html* | grep jpg | tr ";" "\n" | grep -o 'src="[^*]*"' | cut -d '"' -f2 | awk '!a[$0]++' | sed 's#/s_#/l_#g' >>./PICS/.list

rm index.* blogin*

cd PICS
wget -nc -i .list



