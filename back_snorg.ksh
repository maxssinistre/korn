#!/bin/ksh

cd ~/snorg_tees/

for T in $(ls *) ; do 
	xv -maxpect -root -quit $T 
	sleep 30 
done

