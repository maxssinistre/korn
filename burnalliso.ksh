#!/bin/ksh

#for burning all iso's in a folder with alternating devices used

TEMP=.temp_${RANDOM}

SPEED=4

FINISH=FINISHD_DIR

mkdir ${FINISH}

DEV=0

#for ISO in $(ls *.iso | sort -d) ; do	
for ISO in $(ls *.iso | sort -n -t _ -k 3) ; do	

	while [[ $( cdrwtool -i -d /dev/sr${DEV} | grep blank | awk '{ print $NF}' ) != 1 ]] ; do

		echo "waiting for blank dvd to be inserted...."
		echo "previous burn was ${PREVIOUS} "
		echo " processed so far are $(cat ${TEMP} ) "
		sleep 10
	done
	
	PREVIOUS=${ISO}
	echo " cdrecord -eject -v gracetime=2 dev=/dev/sr${DEV} speed=${SPEED} -sao driveropts=burnfree -overburn -data ${ISO} "
	cdrecord -eject -v gracetime=2 dev=/dev/sr${DEV} speed=${SPEED} -sao driveropts=burnfree -overburn -data ${ISO} && mv -v ${ISO} ${FINISH}/
	#cdrecord -eject gracetime=2 dev=/dev/sr${DEV} speed=8 -sao driveropts=burnfree -overburn -data ${ISO} 

	if [ ${DEV} -eq 0 ] ; then

		DEV=1
	else
		
		DEV=0

	fi

	echo ${ISO} >> ${TEMP}
done

rm ${TEMP}
