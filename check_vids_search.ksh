#!/bin/ksh

SEARCH=$@

function old {
for T in $(ls) ; do

	mplayer -idx -zoom -xy 800 -vo fbdev2 -nosound $T
#	mplayer -idx -zoom -xy 1024 -vo fbdev2 -nosound $T
	echo "Do you want to delete $T ? "
	read ANSWER
	if [ $(echo $ANSWER | grep -i y | wc -l) -ge 1 ] ; then

		rm -iv $T
	else
		echo "keeping the file $T "
	fi

 done
}
LIST="$(find ./ -iname "*${SEARCH}*" )"
 
COUNT=$( echo ${LIST} | tr " " "\n" | wc -l )

#for T in $(find ./ -name "*${SEARCH}*" ) ; do 
for T in ${LIST} ; do 
        echo " $COUNT files left "
#        mplayer -nosound -xy 800 -zoom -idx -fs -osdlevel 3 $T  
#        mplayer -xy 800 -zoom -idx -fs -osdlevel 3 $T  
        mplayer -nosound -vo fbdev2 -xy 800 -zoom -idx -fs -osdlevel 3 $T
        let COUNT=$COUNT-1
	        echo "Do you want to delete $T ? "
        read ANSWER
        if [ $(echo $ANSWER | grep -i y | wc -l) -ge 1 ] ; then

                rm -iv $T
        else
                echo "keeping the file $T "
        fi

done

