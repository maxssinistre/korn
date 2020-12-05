#!/bin/ksh

SLEEP=$@
SLEEPY=${SLEEP:-120}
mkdir SMALL

while true ; do 
	date 
	cp -v /tmp/Flash* ./ 
	find  -maxdepth 1 -type f -size -2000k -mmin +3 -name 'Flash*' -exec mv -v {} SMALL/ \; 
	mv $(ls -ltr | awk '/133301/ { print $NF }') $(ls -ltr | awk '/1350958/ { print $NF }') ./SMALL 
	sleep ${SLEEPY}  
done
