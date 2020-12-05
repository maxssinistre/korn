#!/bin/ksh

HERM=$(pwd) 

for DIR in $(ls -ltr | awk '/^drwx/{ print $NF }') ; do

	cd $DIR 

	for FILE in $(ls *.mp4 *.flv) ; do

		mv -v $FILE ../${DIR}_${FILE}

	done

	cd $HERM

done
