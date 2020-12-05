#!/bin/ksh

NUM=$(ls | egrep -i '(flv|mov|wmv|avi|mpg|mpeg)' | wc -l)
NUM2=$NUM

for VID in $(ls | egrep -i '(flv|mov|wmv|avi|mpg|mpeg)') ; do 
	NAME=$(echo ${VID} | cut -d "." -f1)
	echo "converting ${NUM2} of ${NUM}..."
 	ffmpeg -i ${VID} -acodec libamr_nb  -ac 1  -vcodec h263 -s qcif -ar 8000 -r 25 -ab 12.2k ${NAME}.3gp 
	let NUM2=$NUM2-1
done

