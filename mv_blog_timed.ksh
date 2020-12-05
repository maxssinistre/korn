#!/bin/ksh 


NICE=0
NAUGHTY=0
MUSIC=0
HOLD=0

NICE_DIR=/mnt/drive1/NICE_WEB/
MUSIC_DIR=/mnt/drive1/music_blogs/
NAUGHTY_DIR=/mnt/drive1/naughty/
HOLD_DIR=/mnt/drive1/NICE_WEB/TEMP/HOLD/

function usage {

echo"

	simple script to mv temp blogs to correct folder with a time element in the transfer

	t = time to wait before moving in seconds
	d = the directory to move
	n = move to nive directory
	m = move to music directoiry
	x = mopve to naughty directory
	H = move to holde and remove vids
	h = is usage

"
exit 0
}

function hold_remove {

	WORKING=$@

	find ./${WORKING} -size +10k \( -iname "*.w*" -o -iname "*.video*" -o -iname "*.m*" -o -iname "*.avi" -o -iname "*.flv*" \) -exec rm -v {} \;

	mv -v ${WORKING} ${HOLD_DIR}

	cd ${HOLD_DIR}

	archive.ksh -bd

exit 0 

}

function countdown {

COUNT=$@

echo "Start Count"

MIN=1 && for VON in $(seq $(($MIN*${COUNT})) -1 1); do 

	echo -n ":${VON}"
	sleep 1
 
done

echo -e "\n\nBOOOM! Moving files.... "


}

function if_exists {

HOMME=$1
WAWA=$2


if [ $(ls -ld ${HOMME}/${WAWA} 2> /dev/null | wc -l ) -ge 1 ] ; then 

	echo "folder exists. cleaning up....."
	cp -ruv ${WAWA} ${HOMME}
	rm -irf ${WAWA}
	exit 0

fi


}



###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

#echo $@

while getopts ht:d:nxmH option
do
        case $option in
        t) TIMEN="$OPTARG" ;;
	d) DIRECTORY="$OPTARG" ;;
	n) NICE=1 ;;
	x) NAUGHTY=1 ;;
	m) MUSIC=1 ;;
        H) HOLD=1 ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################


if [ $HOLD -eq 1 ] ; then

	hold_remove ${DIRECTORY}

fi



if [ $NICE -eq 1 ] ; then

	MOVE_TO=${NICE_DIR}

elif [ $NAUGHTY -eq 1 ] ; then

        MOVE_TO=${NAUGHTY_DIR}

elif [ $MUSIC -eq 1 ] ; then

        MOVE_TO=${MUSIC_DIR}

else
        MOVE_TO=${NICE_DIR}

fi

if_exists ${MOVE_TO} ${DIRECTORY}

TIME=${TIMEN:-10}

countdown ${TIME} && mv -v ${DIRECTORY} ${MOVE_TO}

#sleep $TIME ; mv -v ${DIRECTORY} ${MOVE_TO}










