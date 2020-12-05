#!/bin/ksh

cd ~/Desktop/newpic_*/

for T in $(ls *) ; do 
        xv -maxpect -root -quit $T 
        sleep 200 
done

