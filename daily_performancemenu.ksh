#!/bin/ksh

wget -np -rkm http://www.performancemenu.com/resources/equipment/
wget -np -rkm http://www.performancemenu.com/resources/events/
wget -np -rkm http://www.performancemenu.com/resources/exercises/

cd www.performancemenu.com/resources/gallery/

wget http://www.performancemenu.com/resources/gallery/index.php\?section=photo\&start=0
NUM=$(grep Last index.php\@section\=photo\&start\=0 | head -1 | cut -d"=" -f4 | cut -d '"' -f1 | tr -d [:cntrl:])
 	
		while [ ${NUM} -ge 0 ]
		do
			wget http://www.performancemenu.com/resources/gallery/index.php\?section=photo\&start=$NUM
			let NUM=$NUM-1
		done

wget http://www.performancemenu.com/resources/gallery/index.php\?section\=video\&start\=0
wget http://www.performancemenu.com/resources/gallery/index.php\?section\=video\&start\=1
wget http://www.performancemenu.com/resources/gallery/index.php\?section\=video\&start\=2

cd -

grep -o 'href="[^*]*"' ./www.performancemenu.com/resources/gallery/*.php* | egrep -i '(mp3|jpg|mov)' | cut -d '"' -f2 | awk '! a[$0]++' > ./PIC/.list

cd PIC

awk '{ print "http://www.performancemenu.com"$0 }' .list > .list2

wget -nc -i .list2
cd -

rm index.php\@section\=photo\&start\=0
rm -f www.performancemenu.com/resources/gallery/*.php*
