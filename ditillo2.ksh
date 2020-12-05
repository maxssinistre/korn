#!/bin/ksh

LIST1=htm_list.txt
LIST2=pic_list.txt

wget http://ditillo2.blogspot.com

mkdir HTML
mkdir PICS

mv index.html HTML

cd HTML

grep -o 'href=[^*]*' index.html | egrep -i ditillo2 | cut -d '"' -f2 | grep -v widget | grep html | cut -d "'" -f2 | awk '!a[$0]++' >> $LIST1

wget -nc -i $LIST1

mv index.html index

grep -o 'href=[^*]*' *.html | egrep -i '(jpg|gif|png)' | cut -d '"' -f2 | cut -d "'" -f2 | awk '!a[$0]++' >> $LIST2

mv $LIST2 ../PICS

cd ../PICS

wget -nc -i $LIST2

cd ../



