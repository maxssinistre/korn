#!/bin/ksh

LIST="
IRONMIND 
LOST_TURNTABLE 
GWENWEIGHT 
FIGURE 
POWER
JENSGYM
DIRT_DIVA
PERFORMANCEMENU
CROSSFIT
KLEMENS
98_rock 
DANJOHN
BASTARDLIFTER
JOEP
DITILLO2
MIDNIGHTRAMBLINGS
POLSKA 
SWEDISH_WEIGHT 
"

HERM=~/nice


for T in $(echo $LIST) ; do
                echo " processing $T folder...."	
		cd $T
        	ksh *.ksh
		echo " finished processing $T folder....."
		cd -
done
