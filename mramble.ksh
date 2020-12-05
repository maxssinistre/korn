#!/bin/ksh

LIST1=htm_list.txt
LIST2=pic_list.txt

mkdir HTML
mkdir PICS

cd HTML

wget http://midnightramblin.wordpress.com/page/1/

grep -o 'src=[^*]*' index.html* | egrep -i '(jpg|gif|png)' | awk '!a[$0]++' | cut -d '"' -f2 >> $LIST2

mv index.html index

mv $LIST2 ../PICS

cd ../PICS

wget -nc -i $LIST2 

detox *

cd ../

