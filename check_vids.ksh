#!/bin/ksh

for T in $(find ./ -type f) ; do
#for T in $(ls) ; do

	mplayer -idx -osdlevel 3 -zoom -xy 800 -vo fbdev2 -nosound $T
#	mplayer -idx -osdlevel 3 -zoom -xy 1024 -vo fbdev2 -nosound $T
	echo "Do you want to delete $T ? "
	read ANSWER
	if [ $(echo $ANSWER | grep -i y | wc -l) -ge 1 ] ; then

		rm -iv $T
	else
		echo "keeping the file $T "
	fi

 done
