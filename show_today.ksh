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
SYMBOLIC=0
COPY=0
BIG=+0k
#FBMODE=$(fbset -i | awk -F '"' '/^mode/ { print $2 }')
FBMODEa=$(fbset -i | awk -F '"' '/^mode/ { gsub ("x","/"); print $2 }')
FBXa=$(fbset -i | awk -F '"' '/^mode/ { print $2 }' | cut -d "x" -f1 )
FBYa=$(fbset -i | awk -F '"' '/^mode/ { print $2 }' | cut -d "x" -f2 )

FBMODE=${FBMODEa:-1024}
FBX=${FBXa:-800}
FBY=${FBYa:-600}
XCLUDE=" "


function usage {
echo '            
                Simple utility to show files in a directory using xv or 
                xanim. Shows files according to age according to your 
                options. Days variable must come first
                -v [+/- a number]use xv for viewing
                -x [+/- a number]use xanim for viewing
		-E use eog for gif/ image viewing
		-A use animate for gif/ image viewing. use something like 800x600 with -s option
		-V use vlc for viewing files. vlc in the frame buffer is not tested.

                -3 use smplayer as smplayer binary
                -2 use mpv as mplayer binary
                -1 use mplayer2 as mplayer binary
                -0 use mplayer as mplayer binary ( or just -m nothing )

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
		-X used with -e to exclude the match
		-m use to watch videos
		-L loop video however many time you specify ( 0 is to loop forever ) use with -m option <enter> starts
		   video again and q moves to the next one. If not specified, file plays once.
		-P playback speed ( usefull when playing back gif files). use fractions to go slow eg:0.2 or 1/2 and 
		   integers to go faster eg:2,3,4,etc . You can use the [ and ] keys to adjust on the fly.
		-o extra adhoc options for helper application : mplayer, xv, fbi, or xanim . Be sure to enclose with quotes !!	
		-n nosound option for videos
		-F extra switches to use for find that are not covered in other switches : example -L for folow symbolic links : -Y "-L"
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
DIRECTORY=$3
#SIZ=${SIZt:-"+0k"}
#DIRECTORY=${LOCAL}/today_$(date +%m%d%y%H%M%S)

if [ -z ${DIRECTORY} ] ; then

DIRECTORY=${LOCAL}/today_$(date +%m%d%y%H)

fi

	
if [ ${SIZt} -eq 1 ] ; then

	SIZ=+0k

fi

mkdir ${DIRECTORY}

if [ $(echo ${EXTt} | wc -c) -ge 3 ] ; then

	find ./ ${ELAPSE} ${FSWITCH} -size ${SIZt} -iname "*${EXT}*" -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${XV} -eq 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${SIZt} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${XANIM} -eq 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${SIZt} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;		

elif [ ${FRAME} -eq 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${SIZt} \( -iname "*.jp*" -o -iname "*.gif*" -o -iname "*.pn*" \) -exec cp -v {} ${DIRECTORY}/ \;

elif [ ${VIDS} -eq 1 ] ; then

	find ./ ${ELAPSE} ${FSWITCH} -size ${SIZt} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -exec cp -v {} ${DIRECTORY}/ \;

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
     if [ $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES ${SINGLE} | wc -l ) -ge 1 ] ; then 
     
     	find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | sort -d | xargs xv -dir ${HERB} -maxpect ${OPTIONS} 
     
     else

     	echo "No files found...."

     fi
     
     #find ./ ${ELAPSE} -print | egrep -i '(jpg|png)' | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | xargs xv -maxpect
	 #find ./ ${ELAPSE} -print | egrep -i '(jpg|png)' | DOUBLES ${SINGLE}| sed 's#\ #\\ #g' | wc -l

}

function slide {

NUM=$1
SIZ=$2

#modified this for cygwin

     if [ $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | wc -l ) -ge 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d | xargs xanim ${OPTIONS} -Sr -Ss${SIZ} -f

     else

        echo "No files found...."

     fi
		  
}

function Eeog {

NUM=$1
SIZ=$2

#modified this for cygwin

     if [ $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | wc -l ) -ge 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d | xargs eog -s -f
#        eog -f $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d )


     else

        echo "No files found...."

     fi
		  
}

function Aanimate {

NUM=$1
SIZ=$2

if [ -z ${SIZ} ] ; then

	OPT=""

else

	OPT="-resize ${SIZ}"

fi

echo "opt = $OPT"
echo "size = $SIZ"
echo "elapse = $ELAPSE "
echo "num = $NUM"
echo "big = $BIG"
echo "extnsion = $EXT"

#modified this for cygwin

     if [ $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | wc -l ) -ge 1 ] ; then

        find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d | xargs animate ${OPTIONS} ${OPT}

     else

        echo "No files found...."

     fi
		  
}


function framebuffer {

NUM=$1
TIME=$2

if [ $( ps -ef | awk '/X/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | awk '/Xorg/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

	echo "xserver is running.....using xv to show files"
	viewer ${NUM}

else

     if [ $(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | wc -l ) -ge 1 ] ; then

		fbi ${OPTIONS} -t ${TIME} -a $( find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -print | grep -v tbz | egrep -i "(${EXT})" | DOUBLES | sed 's#\ #\\ #g' | sort -d )

     else

             	echo "No files found...."

     fi

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

	if [ $( ps -ef | awk '/X/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "
		echo "find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" -o -iname "*.ogg*" \) -printf '%P\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -fs -osdlevel 3 -idx {} \;"

		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" -o -iname "*.ogg*" \) -printf '%P\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -fs -osdlevel 3 -idx {} \;


	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"

#		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -printf '%p\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -xy ${FBMODE} -zoom -vo fbdev2 -idx -fs -osdlevel 3 {} \;

		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" -o -iname "*.ogg*" \) -printf '%p\n' -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -x ${FBX} -y ${FBY} -zoom -vo fbdev2 -fs -osdlevel 3 -idx {} \;

	fi


else


        if [ $( ps -ef | awk '/X/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then
#	if [ $( ps -ef | grep X | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files  larger that 20k "

		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} ${XCLUDE} -iname "*${EXT}*" -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -fs -osdlevel 3 -idx {} \;
	else
		echo "xserver is not running.....playing video files  larger that 20k using framebuffer 2"

#		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} -iname "*${EXT}*" -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -xy ${FBMODE} -zoom -vo fbdev2 -idx -fs -osdlevel 3 {} \;

		find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} ${XCLUDE} -iname "*${EXT}*" -exec ${MPLAY_BIN} ${OPTIONS} -speed ${SPEED} -loop ${LOOP} ${SOUNDS} -cache 8192 -x ${FBX} -y ${FBY} -zoom -vo fbdev2 -fs -osdlevel 3 -idx {} \;

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


        if [ $( ps -ef | awk '/X/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "


	LISTS=$(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" -o -iname "*.ogg*" \) -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi



	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"


	LISTS=$(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" -o -iname "*.ogg*" \) -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	cvlc ${OPTIONS} --fullscreen --fbdev /dev/fb0 --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi

fi 
#this next part is for when i choose a search
else

        if [ $( ps -ef | awk '/X/ && /r[o]ot/ { print $0 }' | wc -l ) -ge 1 ] ; then
#if [ $( ps -ef | grep X | grep -i server | grep -v grep | wc -l ) -ge 1 ] ; then

		echo "xserver is running.....playing video files no extension larger that 20k "


	LISTS=$(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} ${XCLUDE} -iname "*${EXT}*" -printf '%P\n')

	if [ $(echo ${LISTS} | wc -c) -ge 5 ] ; then

	vlc ${OPTIONS} --fullscreen --rate=${SPEED} ${SOUNDS} ${LISTS}
	
	else

	echo "no files found....."

	fi



	else
		echo "xserver is not running.....playing video files no extension larger that 20k using framebuffer 2"


	LISTS=$(find ./ ${ELAPSE} ${FSWITCH} -size ${BIG} ${XCLUDE} -iname "*${EXT}*" -printf '%P\n')

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

SIZEt=$2

if [ ${XV} -eq 1 ] ; then

#        viewer ${NoM} ${DIR}
        viewer ${NoM} 

elif [ ${XANIM} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        slide ${NoM} ${SIZEt}		

elif [ ${EOG} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        Eeog ${NoM} ${SIZEt}

elif [ ${ANIMATE} -eq 1 ] ; then

#        slide ${NoM} ${DIR}
        Aanimate ${NoM} ${SIZEt}		

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
while getopts :t:ivfc234nXVAExD:S:md:e:sbp:L:P:o:B:F: option
do
      case $option in
                t) NoMt="${OPTARG}" ;;
                v) XV=1 ;;
                V) CVLC=1 ;;
#               v) viewer "$OPTARG" ;;
                x) XANIM=1  ;;
                E) EOG=1  ;;
                A) ANIMATE=1  ;;
                f) FRAME=1  ;;
#               x) slide "$OPTARG" ;;
		X) XCLUDE="!" ;;
                i) interactive ;;
                s) SINGLE=1 ;;
                b) BATCH=1 ;;
                p) PAUSED=${OPTARG} ;;
                d) DIR="${OPTARG}" ;;
		m) VIDS=1  ;;
		n) SOUND=1  ;;
		c) COPY=1  ;;
		2) MPLAY=1  ;;
		3) MPLAY=2  ;;
		4) MPLAY=3  ;;
		D) DIRECT="${OPTARG}" ;;
 		S) SIZE="${OPTARG}" ;;
		B) BIG="${OPTARG}" ;;
		e) EXTt="${OPTARG}" ;;
		L) LOOP="${OPTARG}" ;;
		P) SPEED="${OPTARG}" ;;
		o) OPTIONS="${OPTARG}" ;;
		F) FSWITCH="${OPTARG}" ;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################


PAUSE=${PAUSED:-30}

echo $PAUSE

#NoM=${NoMt:-\+0}
NoM=${NoMt:--99999999999999999999990}
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

if [ $MPLAY -eq 2 ] ; then

	MPLAY_BIN=mpv

elif [ $MPLAY -eq 1 ] ; then

	MPLAY_BIN=mplayer2

elif [ $MPLAY -eq 0 ] ; then

	MPLAY_BIN=mplayer

elif [ $MPLAY -eq 3 ] ; then

        MPLAY_BIN=smplayer


fi


for CHANGE in ${DIR} ; do 
	
	echo "changing to ${CHANGE} ......."

	cd ${CHANGE}

	if [ ${BATCH} -eq 1 ] ; then

		for LIST in $(ls -ltr | awk '/^d/ { print $NF }' | sort -d ) ; do

			echo "working $LIST ......."

			if [ -d ${DIR}/$LIST ] ; then

				cd ${DIR}/$LIST

				if [ $COPY -eq 1 ] ; then

					COPY_ME ${NoM} ${BIG} ${DIRECT}

				elif [ $COPY -eq 0 ] ; then

       					work ${NoM} ${BIG}

				fi
			else

				echo " ${DIR}/${LIST} does no exist ......."

			fi

			cd $HERM 
		done

	elif [ ${BATCH} -eq 0 ] ; then
		
		if [ $COPY -eq 1 ] ; then

			COPY_ME ${NoM} ${BIG} ${DIRECT}

		elif [ $COPY -eq 0 ] ; then

   			work ${NoM} ${BIG}

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

