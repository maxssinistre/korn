#!/bin/ksh


#a little script to convert pics for the movie db website

BACK=0
COVER=0
RENAME=0

function usage {
echo "
	a little script to convert pics for the movie db website
	-f inout file
	-b convert to a backgroud file
	-c convert to a cover file
	-r to rename the file for the type, back or cover
	-h
"
exit 0

}

function back {

IMAGE1=$1
OUTPUT=$2

convert ${IMAGE1} -resize 3840x2160! ${OUTPUT} 

echo "new size is $(identify -format "%wx%h" ${OUTPUT} ) ...."

}

function cover {

IMAGE1=$1
OUTPUT=$2

convert ${IMAGE1} -resize 2000x3000! ${OUTPUT}

#identify -format "%wx%h" ${OUTPUT}
echo "new size is $(identify -format "%wx%h" ${OUTPUT} ) ...."

}

###########################options
[ $# -lt 1 ] && usage

echo $@

while getopts f:bchr option
do
        case $option in
        f) FILE="$OPTARG" ;;
        b) BACK=1 ;;
        c) COVER=1 ;;
	r) RENAME=1 ;;
        h) usage ;;
        *) usage;;

        esac
done


#if [ ${RENAME} -eq 1 ] ; then
if [[ ${RENAME} -eq 1 && ${BACK} -eq 1 ]] ; then

	OUTPUT_MAIN=BACK_${FILE}

elif [[ ${RENAME} -eq 1 && ${COVER} -eq 1 ]] ; then

        OUTPUT_MAIN=COVER_${FILE}

else

	OUTPUT_MAIN=resized_${FILE}

fi


if [ ${BACK} -eq 1 ] ; then

	back ${FILE} ${OUTPUT_MAIN}

elif [ ${COVER} -eq 1 ] ; then

	cover ${FILE} ${OUTPUT_MAIN}

else
	echo "you didn't choose to do anything, consider your options in life....."

fi

if [ $( ls ${OUTPUT_MAIN} | grep -c -i png ) -ge 1 ] ; then

	mogrify -format jpg ${OUTPUT_MAIN} 
	rm -v ${OUTPUT_MAIN}

fi


