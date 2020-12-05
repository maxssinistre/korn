#!/bin/ksh

#LIST=$@

BOTTOM=0
TOP=0
TEMP_FILE=.${RANDOM}_temp
FORCE_FORMAT=0
AUDIO=0
RANDY=0

#for T in $(ls -ltr | awk '/^drwx/ { print $NF }') ; do

function usage {

echo "
	simple script to paralellize downloading of youtube-dl

		-l this is the input list and is mandatory
		-c this is the count of how many items you want to parse through on the list
		-t top - if you want the count to start at the beginning of the file
		-b bottom - if you want the count to start from the end of the file
		-p how many instances of youtube-dl to open up - parralellization setting - default is 6
		-f to force mp4 format - most useful for youtube
		-a use when downloading multiple audio streams and you want to convert to mp3 on the fly
		-r random sleep before downloading ( use with youtube )
		-o extra youtube-dl options
		-h this help doc
		-? might add something else
"
exit 0
}


###########################options
#[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts ahtrfbp:c:l:o: option
do
        case $option in
	a) AUDIO=1 ;;
	r) RANDY=1 ;;
        l) LISTY="$OPTARG" ;;
	c) COUNT="$OPTARG" ;;
	t) TOP=1 ;;
	b) BOTTOM=1 ;;
	f) FORCE_FORMAT=1 ;;
	p) PARR_1="$OPTARG" ;;
	o) OPTIONS="$OPTARG" ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################


LIST=${LISTY:-list1}

if [ ${TOP} -eq 1 ] ; then

	MOD_LIST=$(head -${COUNT} ${LIST})

elif [ ${BOTTOM} -eq 1 ] ; then

	MOD_LIST=$(tail -${COUNT} ${LIST})

else

	MOD_LIST=$(cat ${LIST})

fi


PARR=${PARR_1:-6}
#count=${COUNT:-2}

if [ ${FORCE_FORMAT} -eq 1 ] ; then

	FORM="-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4"
#	FORM="-f \"bestvideo\[ext=mp4\]+bestaudio\[ext=m4a\]/bestvideo+bestaudio\" --merge-output-format mp4"
fi

if [ ${AUDIO} -eq 1 ] ; then

	FORM="--add-metadata --extract-audio --audio-format mp3"
fi

if [ ${RANDY} -eq 1 ] ; then

        INTERVAL="--sleep-interval 1 --max-sleep-interval 30"

else

	INTERVAL=""
fi


#for LINK in $(cat ${MOD_LIST}) ; do
for LINK in ${MOD_LIST} ; do

#        cd $T

        youtube-dl -i ${OPTIONS} ${INTERVAL} ${FORM} -v -t $LINK &
#        youtube-dl.bak -i ${INTERVAL} ${FORM} -v -t $LINK &

        while [ $(ps -ef | awk '/yout[u]be-dl/ { print $0 }' | wc -l ) -gt ${PARR} ] ;

                do echo "too many downloads at once, sleeping for 30"
                sleep 30
        done


      #  cd $HERM

done

