#!/bin/ksh

TODAY=$(date +%b%a%d%y)
RATE_TEMP=$@

RATE=${RATE_TEMP:-256}

function parralell {

PARR=$@

#                        while [ $(ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial | wc -l ) -ge ${PARR} ] ;do
                        while [ $(ps -ef | awk '/\.[w]av|la[m]e/ { print $0 }' | wc -l ) -ge ${PARR} ] ;do
				echo "waiting for processor slots"
				sleep 30
			done
}
function convrt {

WAVY=$@

		cat "${WAVY}".wav | lame --tt "${WAVY}" -h -B ${RATE} - - > ./mp3_${TODAY}/"${WAVY}".mp3
		rm "${WAVY}".wav

}

mkdir ./mp3_${TODAY}


for FILE in $(ls *.flv* *.mp4* *.m4a* *.mkv* *.webm* )
	do
#		WAV=$(echo ${FILE} | cut -d "." -f1)	
		WAV="$(echo ${FILE} | rev | awk -F "." '{ $1="" ; print $0 }' | tr " " "." | rev |sed 's#..$##g')"	
		#mplayer -vc /dev/null -vo /dev/null -idx ${FILE} -ao pcm:fast:file=${WAV}.wav
		mplayer -vc /dev/null -vo /dev/null -idx "${FILE}" -ao pcm:fast:file="${FILE}".wav
#		cat ${WAV}.wav | lame --tt ${WAV} --ta 1xtra -h --vbr-new -V 9 -B 160 - - > ./mp3_${TODAY}/${WAV}.mp3
#		cat ${WAV}.wav | lame --tt ${WAV} --ta 1xtra -h -B 256 - - > ./mp3_${TODAY}/${WAV}.mp3
#		cat ${WAV}.wav | lame --tt ${WAV} --ta 1xtra -h -B ${RATE} - - > ./mp3_${TODAY}/${WAV}.mp3
#		cat ${WAV}.wav | lame --tt ${WAV} -h -B ${RATE} - - > ./mp3_${TODAY}/${WAV}.mp3 &
#		rm ${WAV}.wav

#		convrt ${WAV} &
		convrt "${FILE}" &

		parralell 10 

done
