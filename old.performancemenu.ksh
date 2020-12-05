#!/bin/ksh

wget -np -rkm http://www.performancemenu.com/resources/equipment/
wget -np -rkm http://www.performancemenu.com/resources/events/
wget -np -rkm http://www.performancemenu.com/resources/exercises/

#wget -rkm -np http://www.performancemenu.com/resources/gallery

grep -o 'href="[^*]*"' ./www.performancemenu.com/resources/gallery/*.php* | egrep -i '(jpg|mov)' | cut -d '"' -f2 | awk '! a[$0]++' > ./PIC/.list

cd PIC

awk '{ print "http://www.performancemenu.com"$0 }' .list > .list2

wget -nc -i .list2
