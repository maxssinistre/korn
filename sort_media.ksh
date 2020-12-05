#!/bin/ksh

	for T in $(ls ) ; do 
		mplayer -idx -fs -osdlevel 3 $T 	
		echo "do you want to keep this?"  
		read ANSWER 
			if [ $(echo $ANSWER | grep -i n | wc -l) -gt 0 ] ; then 
			 	echo "removing $T" 
			 	rm -v $T
			else
				echo "keeping file" 
			fi
		done
