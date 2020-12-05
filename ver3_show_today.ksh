#!/bin/ksh -x

#scripot to show pictures in directory


SINGLE=0
XV=0
CVLC=0
XANIM=0
VIDS=0
FRAME=0
MPLAY=0
NoM="-1"
#DIR=./
DIR=$(pwd)
LOCAL=$(pwd)
HERB=${HOME}
BATCH=0
SOUND=0
SIZE=1
EXT=${EXTt:-jp|gif}
LOOP=1
SPEED=1
COPY=0
BIG=+0k

function usage {
echo '            
                Simple utility to show files in a directory using xv or 
                xanim. Shows files according to age according to your 
                options. Days variable must come first
                -v [+/- a number]use xv for viewing
                -x [+/- a number]use xanim for viewing
		-l use vlc for viewing files. vlc in the frame buffer is not tested.
		-S use number to indicate how much to enlarge xanim viewing ; when copy is chosen, this is the min size of the file to be copied
                   default is +0k. You can use plus or minus for ranging like in a normal find command.
		-B the size (bigness) of the files to look for. default is 0k . use plus or minus as needed.
                -f [+/- a number]use fbi for framebuffer viewing of pics
                -i interactive mode
                -t days old , use " +/- number" if nothing entered number is +0 add an M/m to the end of the number to use mmin instead of mtime
		-p if for frambuffer, time to display pic before moving on
                -s when this is chosen, old single instance of a file name will be used, without it,
                   only repeat files in the same directory will be filtered out
                -d Starting directory, you can enter a list. enclose list with quotes 
		   ex.: "ni*" , "dir1 dir2 dir3" or "$(ls -tr | tail -4)"
		-b batch . Descend into each folder one at a time ( speeds up viewing )
		-e the extension you are looking for , default is jpg|gif
		-m use to watch videos
		-L loop video however many time you specify ( 0 is to loop forever ) use with -m option <enter> starts
		   video again and q moves to the next one. If not specified, file plays once.
		-P playback speed ( usefull when playing back gif files). use fractions to go slow eg:0.2 or 1/2 and 
		   integers to go faster eg:2,3,4,etc . You can use the [ and ] keys to adjust on the fly.
		-o extra adhoc options for helper application : mplayer, xv, fbi, or xanim . Be sure to enclose with quotes !!	
		-n nosound option for videos
		-D directory to copy file to when copy is called. default is like ${LOCAL}/today_$(date +%m%d%y%H%M%S)
		-c copy functionality. copy whatever you were searching for to a local directory for easy perusal later 
		   use -e to choose extension your looking for or use what is normal for your viewer choice
		   mplayer = "*.w*" "*.video*" "*.m*" "*.avi" "*.flv*
		   xv,xanim,fbi = jpg, gif
'
 exit 0
}

function COPY_ME {

NUM=$1
SIZt=$2
#SIZ=${SIZt:-"+0k"}
#DIRECTORY=${LOCAL}/today_$(date +%m%d%y%H%M%S)
DIRECTORY=${LOCAL}/today_$(date +%m%d%y%H)

if [ ${SIZt} -eq 1 ] ; then

	SIZ=+0k

fi

mkdir ${DIRECTORY}

if [ $(echo ${EXTt} | wc -c) -ge 3 ] ; then

	find ./ ${ELAPSE} -size ${SIZ} -iname "*${EXT}*" -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${XV} -eq 1 ] ; then

        find ./ ${ELAPSE} -size ${SIZ} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${XANIM} -eq 1 ] ; then

        find ./ ${ELAPSE} -size ${SIZ} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;		

elif [ ${FRAME} -eq 1 ] ; then

        find ./ ${ELAPSE} -size ${SIZ} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${VIDS} -eq 1 ] ; then

	find ./ ${ELAPSE} -size ${SIZ} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -exec cp -v {} ${DIRECTORY}/ \;

fi

}




function DOUBLES {

 
if [ ${SINGLE} -eq 0 ]  
then
        awk 'BEGIN {FS = "/"} ! a[ $0 ]++'
else
        awk 'BEGIN {FS = "/"} ! a[ $NF ]++'
fi
}

function viewer {


NUM=$1
#modified this for cygwin
     find ./ ${ELAPSE} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | sort -d | xargs xv -dir ${HERB} -maxpect ${OPTIONS} 
     #find ./ ${ELAPSE} -print | egrep -i '(jpg|png)' | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | xargs xv -maxpect
	 #find ./ ${ELAPSE} -print | egrep -i '(jpg|png)' | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | wc -l

}

function slide {

NUM=$1
SIZ=$2

#modified this for cygwin
        find ./ ${ELAPSE} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d | xargs xanim ${OPTIONS} -Sr -Ss${SIZ} -f

}

function framebuffer {

NUM=$1
TIME=$2

if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

	echo "xserver is running.....using xv to show files"
	viewer ${NUM}
else

	fbi ${OPTIONS} -t ${TIME} -a $( find ./ ${ELAPSE} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d )

fi	

}


function video {

NUMt=$1
#NUM=${NUMt:-+0}
SOUNDS=$2

if [ ${SOUND} -eq 1 ] ; then
	SOUNDS=-nosound
elif [ ${SOUND} -eq 0 ] ; then
	SOUNDS=''
fi

echo ${EXT}

if [ $(echo ${EXT} | grep jp | wc -l) -ge 1 ] ; then

#	EXT=.mov

	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "

		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -printf '%P\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -idx -fs -osdlevel 3 {} \;


	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"

		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -printf '%p\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -xy 800 -zoom -vo fbdev2 -idx -fs -osdlevel 3 {} \;

	fi


else


	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files  larger that 20k "

		find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -idx -fs -osdlevel 3 {} \;
	else
		echo "xserver is not running.....playing video files  larger that 20k using framebuffer 2"

		find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -xy 800 -zoom -vo fbdev2 -idx -fs -osdlevel 3 {} \;

	fi

fi

#OLD searches
#		find ./ ${ELAPSE} -size +20k \( -iname "*.w*" -o -iname "*${EXT}*" -o -iname "*.video*" -o -iname "*.m*" -o -iname #"*.avi" -o -iname "*.flv*" \) -printf '%p\n' -exec mplayer ${SOUNDS} -cache 8192 -xy 800 -zoom -vo fbdev2 -idx -fs -osdlevel 3 {} \;
#		find ./ ${ELAPSE} -size +20k \( -iname "*.w*" -o -iname "*${EXT}*" -o -iname "*.video*" -o -iname "*.m*" -o -iname #"*.avi" -o -iname "*.flv*" \) -printf '%P\n' -exec mplayer ${SOUNDS} -cache 8192 -idx -fs -osdlevel 3 {} \;

}

function videolan {

NUMt=$1
#NUM=${NUMt:-+0}
SOUNDS=$2

if [ ${SOUND} -eq 1 ] ; then
	SOUNDS=--noaudio
elif [ ${SOUND} -eq 0 ] ; then
	SOUNDS=''
fi

echo ${EXT}

if [ $(echo ${EXT} | grep jp | wc -l) -ge 1 ] ; then


	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "


	LISTS=$(find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi



	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"


	LISTS=$(find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	cvlc ${OPTIONS} --fullscreen --fbdev /dev/fb0 --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi

fi 
#this next part is for when i choose a search
else

	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "


	LISTS=$(find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi



	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"


	LISTS=$(find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	cvlc ${OPTIONS} --fullscreen --fbdev /dev/fb0 --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi

fi 

fi



}


function interactive {

echo "What viewer to use ? (xv,xanim,fbi or video)"
read CHOICE

echo "How many days back ?( use plus or minus and the number)"
read NUM

if $CHOICE == xanim 
then
        slide ${NoM} ${SIZE}

elif $CHOICE == xv
then

        viewer ${NoM}

elif $CHOICE == fbi
then
        framebuffer ${NoM}

elif $CHOICE == video
then
        video ${NoM}

elif [ ${CVLC} -eq 1 ] 
then

        videolan ${NoM}

fi
}

function work {

if [ ${XV} -eq 1 ] ; then

#        viewer ${NoM} ${DIR}
        viewer ${NoM} 

elif [ ${XANIM} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        slide ${NoM} ${SIZE}		

elif [ ${FRAME} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        framebuffer ${NoM} ${PAUSE}  

elif [ ${VIDS} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        video ${NoM}

elif [ ${CVLC} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        videolan ${NoM}
fi

}

function copornot {

N0M=$1

if [ $COPY -eq 1 ] ; then

	COPY_ME ${N0M}

elif [ $COPY -eq 0 ] ; then

       	work ${N0M}

fi

}


###########################options
[ $# -lt 1 ] && usage

#eval getopts :t:iv:x:d:s option
while getopts :t:ivfc2nlxS:md:e:sbp:L:P:o:B: option
do
      case $option in
                t) NoMt="${OPTARG}" ;;
                v) XV=1 ;;
                l) CVLC=1 ;;
#               v) viewer "$OPTARG" ;;
                x) XANIM=1  ;;
                f) FRAME=1  ;;
#               x) slide "$OPTARG" ;;
                i) interactive ;;
                s) SINGLE=1 ;;
                b) BATCH=1 ;;
                p) PAUSED=${OPTARG} ;;
                d) DIR="${OPTARG}" ;;
		m) VIDS=1  ;;
		n) SOUND=1  ;;
		c) COPY=1  ;;
		2) MPLAY=1  ;;
		S) SIZE="${OPTARG}" ;;
		B) BIG="${OPTARG}" ;;
		e) EXTt="${OPTARG}" ;;
		L) LOOP="${OPTARG}" ;;
		P) SPEED="${OPTARG}" ;;
		o) OPTIONS="${OPTARG}" ;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################


PAUSE=${PAUSED:-30}

echo $PAUSE

NoM=${NoMt:-\+0}
EXT=${EXTt:-jp|gif}

echo $NoM

#cd ${DIR}

HERM=$(pwd)


if [ $(echo ${NoM} | grep -i m | wc -l) -eq 1 ] ; then

	TIMES=$(echo ${NoM} | tr -d \[:alpha:]\ )
#	TIMES=$(echo ${NoM} | tr -d "m" )

	echo ${NoM} $TIMES

	ELAPSE="-mmin ${TIMES}"
else 

	TIMES=$(echo ${NoM} | tr -d \[:alpha:]\ )

	ELAPSE="-mtime ${TIMES}"

fi	


if [ $MPLAY -eq 1 ] ; then

	MPLAY_BIN=mplayer2

elif [ $MPLAY -eq 0 ] ; then

	MPLAY_BIN=mplayer

fi


for CHANGE in ${DIR} ; do 
	
	echo "changing to ${CHANGE} ......."

	cd ${CHANGE}

	if [ ${BATCH} -eq 1 ] ; then

		for LIST in $(ls -ltr | awk '/^d/ { print $NF }' | sort -d ) ; do

			echo "working $LIST ......."
			cd ${DIR}/$LIST
			if [ $COPY -eq 1 ] ; then

				COPY_ME ${NoM} ${SIZE}

			elif [ $COPY -eq 0 ] ; then

       				work ${NoM}

			fi
			cd $HERM 
		done

	elif [ ${BATCH} -eq 0 ] ; then
		
		if [ $COPY -eq 1 ] ; then

			COPY_ME ${NoM} ${SIZE}

		elif [ $COPY -eq 0 ] ; then

   			work ${NoM}

		fi

	fi

cd ${HERM} 

done

exit 0





#old searches
#		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname #"*.flv*" \) -printf '%P\n' -exec vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} {} \;
#		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname #"*.flv*" \) -printf '%P\n' -exec cvlc ${OPTIONS} --rate=${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -idx -fs -osdlevel 3 {} \;
#		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname #"*.flv*" \) -printf '%p\n' -exec vlc -I ncurses ${OPTIONS} --rate=${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -xy 800 -zoom --fbdev /#dev/fb0 {} \;
#		find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -exec vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} {} \;
#		find ./ ${ELAPSE} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname #"*.flv*" \) -printf '%p\n' -exec cvlc ${OPTIONS} --fullscreen --rate=${SPEED} --fbdev /dev/fb0 {} \;
#		find ./ ${ELAPSE} -size ${BIG} -iname "*${EXT}*" -exec cvlc ${OPTIONS} --fullscreen --rate=${SPEED} --fbdev /dev/fb0 {} #\;

