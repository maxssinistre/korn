#!/bin/ksh

TODAY=$(date +%b%a%d%y)

mkdir ./mp3_${TODAY}


for FILE in $(ls | egrep -i '(wma|mp4|flv|ra|rm|avi|mp2)')
	do
		WAV=$(echo ${FILE} | sed 's#.wma$##g' )	
		#WAV=$(echo ${FILE} | cut -d "." -f1)	
		mplayer -vc /dev/null -vo /dev/null -idx ${FILE} -ao pcm:fast:file=${WAV}.wav
#the below is good enough for most streams
		cat ${WAV}.wav | lame -q 0 --tt ${WAV} --ta "ripped from wma" --vbr-new --preset medium -V 9 -B 256 - - > ./mp3_${TODAY}/${WAV}.mp3
		#The below is for crazy high quality, usually noty necessary for a stream	
#		cat ${WAV}.wav | lame -q 0 --tt ${WAV} --ta "ripped from wma" --vbr-new --preset extreme -V 9 -B 256 - - > ./mp3_${TODAY}/${WAV}.mp3
		rm ${WAV}.wav
done
