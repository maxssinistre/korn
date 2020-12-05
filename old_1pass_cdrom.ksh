#!/bin/ksh
echo "ripping entire DVD....."

TODAY=$(date +%Y%m%d%H%M%S)

mkdir $TODAY

cd $TODAY

echo "and what bitrate? "
read BIT

NUM=$(mplayer -dvd-device /mnt/cdrom dvd://1 -vo null -ao null -frames 0 -v 2>&1 | grep ^There |grep titles|grep -o [0-9]*[0-9])

count=$((${NUM}/1))

while test $count -gt 0
do
        mencoder -dvd-device /mnt/cdrom	dvd://$count -idx -o dvd_extract_$(date +%Y%m%d%H%M%S).avi -alang en -ovc lavc -oac copy -lavcopts vcodec=mpeg4:vbitrate=$BIT
 dvd_extract_$(date +%Y%m%d%H%M%S).avi
#	mencoder dvd://$count -dvd-device /dev/sr0 -alang English -oac mp3lame -lameopts abr:br=128 -ovc lavc -lavcopts vcodec=mpeg4:vhq:v4mv:vqmin=2:vbitrate=$BIT -vf pp=de,crop=0:0:0:0,scale=480:-2 -of mpeg -o dvd_extract_$(date +%Y%m%d%H%M%S).mpg
	let count=$count-1
done

echo " Done Beotch!!! "

cd -

#mencoder dvd://2 -dvd-device /dev/sr0  -alang English -oac mp3lame -lameopts abr:br=128  -ovc lavc -lavcopts vcodec=mpeg4:vhq:v4mv:vqmin=2:vbitrate=286 -vf pp=de,crop=0:0:0:0,scale=480:-2  -of mpeg  -o "/home/salsa/homevid2.mpg"
