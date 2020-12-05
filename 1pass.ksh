#!/bin/ksh
echo "ripping entire DVD....."

TODAY=$(date +%Y%m%d%H%M%S)

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
#nice -n 19 mencoder -dvd-device ${DEVICE} /mnt/usb dvd://${count} -ofps 23.976 -oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid -xvidencopts pass=1:bitrate=${VBIT} -o /dev/null

nice -n 19 mencoder -dvd-device ${DEVICE} dvd://${count} -alang en -ofps 23.976 -oac mp3lame -lameopts abr:br=${ABIT} -ovc xvid -sid 42 -xvidencopts bitrate=${VBIT} -o ${NAME}_$(date +%Y%m%d%H%M%S).avi

	let count=$count-1
done

echo " Done Beotch!!! "

cd -

#mencoder dvd://2 -dvd-device /dev/sr0  -alang English -oac mp3lame -lameopts abr:br=128  -ovc lavc -lavcopts vcodec=mpeg4:vhq:v4mv:vqmin=2:vbitrate=286 -vf pp=de,crop=0:0:0:0,scale=480:-2  -of mpeg  -o "/home/salsa/homevid2.mpg"
