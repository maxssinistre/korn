#!/bin/ksh -x

#dvd ripping software script :)


TODAY=$(date +%Y%m%d%H%M%S)
TWOPASS=0
ONEPASS=1
ADDDATE=0
FEEFO=0 
ASPECT="16:9"



function usage {

echo " A simple dvd ripping software script :)

	-t 2 pass encoding of dvd
	-i location of dvd file (dvd or mounted image)
	-n output name - default = dvd_extract_TODAYDATSDATEHOURMINSEC
	-v video bitrate default is 800 - please note to have the encoder come up with the bitrate automatically give it the goal filesize
           with a minus in front of it. For instance -700000 equals 700M and -1400000 equals 1.4GB
	-a audio bitrate default is 128
	-c this is the codec. Y ou can choose between 1(xvid) or 2(x264) with the default being mp4. 
           1 = xvid (divx) encoding 
           2 = x264 long compress time , smaller file
           anything else = mpeg4 generally good quality - fast encoding
	-d add date to name
	-f fifo hack - does not need bitrate info - straight copy
	-I interactive
	-h this help text
	
"
exit 0
}


function codec {

CHOICE=$@

	if [ $CHOICE -eq 1 ] ; then

#		CODEC="-ovc xvid"
		CODEC="-oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid"
		EXTENSION="avi"

	elif [ $CHOICE -eq 2 ] ; then

#		CODEC="-oac mp3lame -lameopts abr:br=${ABIT} -ovc x264"
		CODEC="-oac copy -ovc x264 -x264encopts preset=veryslow:tune=film:crf=15:frameref=15:fast_pskip=0:threads=auto"
		EXTENSION="avi"

	else 

#		CODEC="-ovc lavc -lavcopts vcodec=mpeg4"
		CODEC="-oac mp3lame -lameopts abr:br=${ABIT} -ovc lavc -lavcopts vcodec=mpeg4"
		EXTENSION="mp4"

	fi



}


function interact {
echo "ripping entire DVD....."

echo "and what video bitrate? the default is 800. if that is good enough, just press enter"
read tmp_VBIT
VBIT=${tmp_VBIT:-800}

echo "what audio bitrate? the default is 128. if that is good, just press enter"
read tmp_ABIT
ABIT=${tmp_ABIT:-128}

echo " what do i name it ? if you want it to be \"dvd_extract\" just press enter"
read NOMEN
NAME=${NOMEN:-dvd_extract}

echo "what dvd-device option do you want ? to use the default /dev/sr0 just press enter"
read DVD
DEVICE=${DVD:-/dev/sr0}

DIR=${NAME}_${TODAY}
mkdir ${DIR}
cd ${DIR}

NUM=$(mplayer -dvd-device ${DEVICE} dvd://1 -vo null -ao null -frames 0 -v 2>&1 | grep ^There |grep titles|grep -o [0-9]*[0-9])

count=$((${NUM}/1))

ALL=$((${NUM}/1))

while test $count -gt 0
do

echo " processing title $count of $ALL "
nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 23.976 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=1:bitrate=${VBIT} -o /dev/null

nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 23.976 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=2:bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi

	let count=$count-1
done

echo " Done Beotch!!! "

cd -

}

function feefood {

	echo "not done yet"

	DIR=${NAME}_${TODAY}
	mkdir ${DIR}
	cd ${DIR}

	NUM=$(mplayer -dvd-device ${DEVICE} dvd://1 -vo null -ao null -frames 0 -v 2>&1 | grep ^There |grep titles|grep -o [0-9]*[0-9])

	count=$((${NUM}/1))

	ALL=$((${NUM}/1))

	while test $count -gt 0
	do

		echo " processing title $count of $ALL "

		mkfifo ./videoPipe

		cat ./videoPipe >> video.avi | mplayer - &

		mplayer dvd://${count} -dvd-device ${DEVICE} -autosync 30 -dumpstream -dumpfile ./videoPipe

		mv -v video.avi ${NAME}_$(date +%Y%m%d%H%M%S).avi

		rm ./videoPipe

		let count=$count-1
	done

echo " Done Beotch!!! "

cd -

}






###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts tc:i:n:b:a:o:v:a:dfh option
do
	case $option in
        t) TWOPASS=1 ;;
        i) DEVICE="$OPTARG" ;;
        n) NAME="$OPTARG" ;;
        v) tmp_VBIT="$OPTARG" ;;
        a) tmp_ABIT="$OPTARG" ;;
	c) CODEC="$OPTARG" ;;
        d) ADDDATE=1 ;;
        f) FEEFO=1 ;;
        h) usage;;
	*) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)

##########################################


VBIT=${tmp_VBIT:-800}

ABIT=${tmp_ABIT:-128}



if [ $TWOPASS -eq 1 ] ; then

	ONEPASS=0

	DIR=${NAME}_${TODAY}
	mkdir ${DIR}
	cd ${DIR}

	NUM=$(mplayer -dvd-device ${DEVICE} dvd://1 -vo null -ao null -frames 0 -v 2>&1 | grep ^There |grep titles|grep -o [0-9]*[0-9])

	count=$((${NUM}/1))

	ALL=$((${NUM}/1))

	while test $count -gt 0
	do

		echo " processing title $count of $ALL "
		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 29.97 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=1:bitrate=${VBIT} -o /dev/null
#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 23.976 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=1:bitrate=${VBIT} -o /dev/null

		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 29.97 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=2:bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi
#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -ofps 23.976 -alang en -oac mp3lame -lameopts abr:br=${ABIT} -sid 42 -ovc xvid -xvidencopts pass=2:bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi

		let count=$count-1
	done

	echo " Done Beotch!!! "

	cd -

elif [ $FEEFO -eq 1 ] ; then

	ONEPASS=0

	feefood

elif [ $ONEPASS -eq 1 ] ; then

	DIR=${NAME}_${TODAY}
	mkdir ${DIR}
	cd ${DIR}

	NUM=$(mplayer -dvd-device ${DEVICE} dvd://1 -vo null -ao null -frames 0 -v 2>&1 | grep ^There |grep titles|grep -o [0-9]*[0-9])

	count=$((${NUM}/1))

	ALL=$((${NUM}/1))

	codec ${CODEC}

	while test $count -gt 0
	do

		echo " processing title $count of $ALL "
#nice -n 19 mencoder -dvd-device ${DEVICE} /mnt/usb dvd://${count} -ofps 23.976 -oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid -xvidencopts pass=1:bitrate=${VBIT} -o /dev/null

#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 23.976 -oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi

#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 29.97 -oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi

#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 29.97 -oac mp3lame -lameopts abr:br=${ABIT} -ovc lavc -lavcopts vcodec=mpeg4 -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).mp4

#		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 29.97 -oac mp3lame -lameopts abr:br=${ABIT} ${CODEC} -aspect ${ASPECT} -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).${EXTENSION}

		nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 29.97 ${CODEC} -aspect ${ASPECT} -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).${EXTENSION}

# mencoder file.wmv -ofps 23.976 -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o file.avi

		let count=$count-1
	done

	echo " Done Beotch!!! "

	cd -

fi




#mencoder dvd://2 -dvd-device /dev/sr0  -alang English -oac mp3lame -lameopts abr:br=128  -ovc lavc -lavcopts vcodec=mpeg4:vhq:v4mv:vqmin=2:vbitrate=286 -vf pp=de,crop=0:0:0:0,scale=480:-2  -of mpeg  -o "/home/salsa/homevid2.mpg"

#added "-sid 42" to get rid of subtitles
