#!/bin/ksh

HERM=$(pwd)
#THRESHOLD=480


LIST=$@

if [ -z ${LIST} ] ; then

	LIST="$(ls -ltr | awk '/^d|^lrw/ { print $NF }')"

fi

#chmod -R 777 *

for FOLDER in ${LIST} ; do 	


	chmod -R 777 ${HERM}/${FOLDER}
	THRESHOLD_A=$(du -s ${HERM}/${FOLDER}/*.avi ${HERM}/${FOLDER}/*.mp4 ${HERM}/${FOLDER}/*.m4v ${HERM}/${FOLDER}/*.mkv 2>/dev/null | sort -nr | head -1 | cut -f1) 
	let THRESHOLD=$THRESHOLD_A-50000
				   
	if [ $(ls ${HERM}/${FOLDER}/EXTRAS*.tar | wc -l ) -lt 1 ] ; then

		mkdir ${HERM}/${FOLDER}/EXTRAS 

        fi

	mv -v ${HERM}/${FOLDER}/EXTRAS/* ${HERM}/${FOLDER}/ 2>/dev/null
	find ${HERM}/${FOLDER} \( -iname "*.avi" -o -iname "*.mp4" -o -iname "*.m4v" -o -iname "*.mkv" \) -size -${THRESHOLD} -exec mv -uv {} ${HERM}/${FOLDER}/EXTRAS/ \; 

#read

done

function make_small {
for T in ${LIST} ; do 

	cd $T 	
	if [ $(ls EXTRAS*.tar | wc -l ) -lt 1 ] ; then

		archive.ksh -td 

	fi
	cd $HERM 

done
}

make_small

#       find ${HERM}/${FOLDER} -name '*.avi' -size -${THRESHOLD}M -exec mv -uv {} ${HERM}/${FOLDER}/EXTRAS/ \;
#       find ${HERM}/${FOLDER} -name '*.avi' -exec ls -ltrh {} \;

