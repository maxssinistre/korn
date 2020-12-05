#!/bin/ksh

cd ~/Desktop/newpic_*/SHIRT_WOOT/

for T in $(ls *Detail*) ; do 
	xv -maxpect -root -quit $T 
	sleep 200 
done

