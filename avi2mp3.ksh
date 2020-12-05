#!/bin/ksh

TODAY=$(date +%b%a%d%y)

mkdir ./mp3_${TODAY}


for FILE in $(ls *.avi)
	do
		WAV=$(echo ${FILE} | cut -d "." -f1)	
		mplayer -vc /dev/null -vo /dev/null -idx ${FILE} -ao pcm:fast:file=${WAV}.wav
		cat ${WAV}.wav | lame --tt ${WAV} --ta 1xtra -h --vbr-new -V 9 -B 160 - - > ./mp3_${TODAY}/${WAV}.mp3
		rm ${WAV}.wav
done
