#!/bin/ksh


function usage {
echo "
a simple script with some preset variables for x265 encoding of video files

	-i input file name
	-o output file name (optional, if you dont't put anthing here it will name the file the same as the input file with a random number and .mp4 appended) . Do not use in batch mode.
	-v video bitrate
	-a audio bitrate
	-B batch mode. Convert all files in the directory that have the extension .nuv .mp4 .mpeg .mpg .flv (Upper or Lowercase) . Will also look for file that start with Flash. Disables custom fie naming and uses defaults.
	-q quaility(crf value) The range of the quantizer scale is 0-51: where 0 is lossless, 23 is default, and 51 is worst        
           possible. A lower value is a higher quality and a subjectively sane range is 18-28. Consider 18 to be visually 
           lossless or nearly so: it should look the same or nearly the same as the input but it isn't technically lossless.
	-h this usage blurb
	-A This is for the aspect ratio of the output movie.
		aspect=<0-3>
		Specify input aspect ratio:
		0: 1:1
		1: 4:3 (default)
		2: 16:9
		3: 2.21:1
	-r choose this to repair a file **you will need space to decompress the video of the file(like 30GB for 1/2 hour at medium quality)
	-t for subtitle track to choose ( default is track 2000, as in no subtitles, this is the default )
	-l choose the language track - eng is the default
	-m choose to add \"-map 0\" to command in order to override defaults - this is usefull sometimes to get correct streams
"
exit 0
}


function single_pass {

#nice -n 19 ffmpeg ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT} -o ${OUTPUT}
echo "nice -n 19 ffmpeg -i ${INPUT} ${SWITCHES} ${OUTPUT}"
nice -n 19 ffmpeg -i ${INPUT} ${SWITCHES} ${OUTPUT}

}

function two_pass {

#PASS1="-turbo ${SWITCHES}:pass=1"
PASS1="${SWITCHES}:pass=1"
PASS2="${SWITCHES}:pass=2"

#nice -n 19 ffmpeg ${INPUT} -turbo -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=1:bitrate=${V_BIT} -o /dev/null
nice -n 19 ffmpeg -i ${INPUT} ${PASS1} -o /dev/null


#nice -n 19 ffmpeg ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=2:bitrate=${V_BIT} -o ${OUTPUT}
nice -n 19 ffmpeg -i ${INPUT} ${PASS2} -o ${OUTPUT}

}

function repair {

	PASS1="${SWITCHES}:pass=1"
	PASS2="${SWITCHES}:pass=2"

#	ffmpeg ${INPUT} -oac pcm -ovc raw -o output.mp4
	mencoder ${INPUT} -oac pcm -ovc raw -o output.mp4
#	ffmpeg ${INPUT} -oac pcm -ovc raw -sid -o output.mp4

#	ffmpeg -idx output_1.mp4 -ovc copy -oac copy -o output.mp4

#	rm output_1.mp4

#	divx_encode.ksh -i output.mp4 -o ${OUTPUT}.fixed.mp4

if [ ${PASS} -eq 2 ]
	then
	
		nice -n 19 ffmpeg output.mp4 ${PASS1} > /dev/null

		nice -n 19 ffmpeg output.mp4 ${PASS2} ${OUTPUT}
	else

		nice -n 19 ffmpeg output.mp4 ${SWITCHES} ${OUTPUT}

fi

	nice -n 19 ffmpeg -idx ${INPUT} -ovc copy -fafmttag -oac copy ${OUTPUT}.fixed.mp4

#        nice -n 19 ffmpeg -idx output.mp4 -ovc copy -oac copy -o output.2

#	rm output.*

#	nice -n 19 ffmpeg output.2 ${SWITCHES} -o ${OUTPUT}.fixed2.mp4

#	rm output.*
	
}

function interactive {

echo " What video bitrate do you want to use ? (defaults 800)"
read VBIT
V_BIT=${VBIT:-800}

echo "What audio bitrate do you want to use? (defaults 128)"
read ABIT
A_BIT=${ABIT:-128}

echo "Do you want single or 2pass encoding ?i ( please enter 1 or 2 , default is 1)"
read PASS_TEMP
PASS=${PASS_TEMP:-1}

while [[ ${PASS} -gt 2 || ${PASS} -lt 1 ]] ; do

	echo " Please enter 1 or 2 numbnuts"
	read PASS

done

echo "please give the full path of the input file"
read INPUT


echo "please give the full path of the output file , you can just press enter an you wil get a file with the same name but with a random number and mp4 appended to it"
read OUTPUT_TEMP

OUTPUT=${OUTPUT_TEMP:-${INPUT}_${RANDOM}.mp4}


}

function PROGRAM {

if [ ${REPAIR} -eq 1 ] 
then
	repair

elif [ ${INTERACT} -eq 1 ]
then
	interactive

elif [ ${PASS} -eq 2 ]  
then
	two_pass
else
	single_pass
fi

}
    
function settings {

ASPECT=${A_SPECT:-1}

#SWITCHES="-ofps 23.976 -oac mp3lame -alang ${LANG} -slang ${LANG} -sid ${SUBTRACK} -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT}:autoaspect=${ASPECT}"
#SWITCHES="-ofps 29.97 -oac mp3lame -alang ${LANG} -slang ${LANG} -sid ${SUBTRACK} -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT}:autoaspect=${ASPECT}"
#ffmpeg -threads 0 -i "${INPUT_FILE}" -bsf:a aac_adtstoasc -c:v libx265 -preset medium -x265-params crf=28 -c:a copy -metadata:s:a:0 language=eng -metadata title="${NAME}" -metadata media_type=10 -metadata album="${SERIES}" -metadata show="${SERIES}" -metadata season_number="${SEASON_NUMBER}" -metadata episode_sort="${EPISODE_NUMBER}" -metadata episode_id=${EPISODE_ID} -metadata hd_video=1 -metadata network="${ORIGINAL_CHANNEL}" -metadata genre="${GENRE}" -metadata synopsis="${DESCRIPTION}" -metadata comment="${SHORT_DESCIPTION}" "${OUTPUT_FILE_WITH_PATH}.mp4"
#ffmpeg -threads 0 -bsf:a aac_adtstoasc -c:v libx265 -preset medium -x265-params crf=28 -c:a copy "${OUTPUT_FILE_WITH_PATH}.mp4"
#SWITCHES="-threads 0 -bsf:a aac_adtstoasc -c:v libx265 -preset medium -x265-params crf=27 -c:a copy -alang ${LANG} -slang ${LANG} -sid ${SUBTRACK} -lameopts abr:br=${A_BIT} -lavencopts bitrate=${V_BIT}:autoaspect=${ASPECT}"
#SWITCHES="-threads 0 -bsf:a aac_adtstoasc -c:v libx265 -preset medium -x265-params crf=27:bitrate=${V_BIT}:autoaspect=${ASPECT} -c:a libmp3lame -vbr 3 -b:a ${A_BIT}"
#SWITCHES="-threads 0 -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT}:autoaspect=${ASPECT} -c:a libmp3lame -vbr 3 -b:a ${A_BIT}k"
#SWITCHES="-threads 0 -map 0 -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT}:autoaspect=${ASPECT} -c:a libmp3lame -b:a ${A_BIT}k"
#SWITCHES="-threads 0 -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT} -map 0:a:3 -map 0:s:2 -c:a:3 libmp3lame -b:a:3 ${A_BIT}k"
#SWITCHES="-threads 0 -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT} -c:a:0 libmp3lame -b:a ${A_BIT}k -c:a libmp3lame -b:a:1 ${A_BIT}k"

SWITCHES="-threads 0 ${MAP} -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT} -c:a libmp3lame -b:a ${A_BIT}k"
#or 
#SWITCHES="-threads 0 -c:v libx265 -preset medium -x265-params crf=${QUAL}:bitrate=${V_BIT} -c:a libmp3lame -b:a ${A_BIT}k ${MAP}"





if [ ${SETTINGS} -eq 1 ] 
then 

	get_settings $INPUT
else
	echo " i did not automatically get you settings"
	
fi


echo "$MOVIE_LENGTH_TEMP MOVIE_LENGTH_TEMP"
echo "$HR		HR"
echo "$MIN		MIN"
echo "$HR_SEC		HR_SEC"
echo "$MIN_SEC		MIN_SEC"
echo "$SEC_SEC		SEC_SEC"
echo "$MOVIE_LENGTH	MOVIE_LENGTH"
echo "$MOVIE_SIZE_TEMP	MOVIE_SIZE_TEMP"
echo "$MOVIE_SIZE	MOVIE_SIZE"
echo "$V_BIT		V_BIT"
echo "$V_BIT_TEMP1  	V_BIT_TEMP1"
echo "$V_BIT		V_BIT"
echo "$PASS		PASS"
}



######################VARIABLES#############################

[ $# -lt 1 ] && usage

INTERACT=0
BATCH=0
SETTINGS=0
REPAIR=0
MAP=""

echo $@

	while getopts :v:a:i:o:Ip:q:BrGA:t:l:m option
	do
        	case $option in
			v) VBIT=${OPTARG} ;;
			a) ABIT=${OPTARG} ;;
			p) PASS_TEMP=${OPTARG} ;;
			I) INTERACT=1 ;;
			i) INPUT=${OPTARG} ;;
			o) OUTPUT_TEMP=${OPTARG} ;;
			B) BATCH=1 ;;
			m) MAP="-map 0:a" ;;     #changed map 0 to map 0:a in order to map only the audio streams and not the subtitle streams - will think about subtitles later
#			x) X_AXIS=${OPTARG} ;;
#			y) Y_AXIS=${OPTARG} ;;
			q) QAUL_TEMP=${OPTARG} ;;
			G) SETTINGS=1 ;;
			A) A_SPECT=${OPTARG} ;;
			r) REPAIR=1 ;;
			t) SUBTRACK=${OPTARG} ;;
			l) LANG=${OPTARG} ;;
			*) usage;;
	esac
	done
shift $(expr $OPTIND - 1)

OUTPUT=${OUTPUT_TEMP:-${INPUT}_${RANDOM}.mp4}
PASS=${PASS_TEMP:-1}

while [[ ${PASS} -gt 2 || ${PASS} -lt 1 ]] ; do

        echo " Please enter 1 or 2 numbnuts"
	        read PASS

		done

A_BIT=${ABIT:-160}
V_BIT=${VBIT:-900}
SUBTRACK=${SUBTRACK:-2000}
LANG=${LANG:-eng}
QUAL=${QUAL_TEMP:-26}

#if [[ -z $INPUT ]] && [[ $INTERACT -eq 0 ]];then
if [[ -z $INPUT && $INTERACT -eq 0 && $BATCH -eq 0 ]];then
        echo " you forgot to put in an input file name"
	usage
fi



######################PROGRAM#############################


#X_AXIS=${OPTARG} 
#Y_AXIS=${OPTARG} 



#exit 0
 
if [ $BATCH -eq 1 ] 
then
	OUTPUT=""
	for FILE in $(ls | egrep -i '(.ts|.avi|.mp4|.m4a|.mov|.mkv|.wmv|.nuv|.mp4|.mpg|.mpeg|Flash|.flv|.3gp)') 
	do	
		INPUT=${FILE}
		OUTPUT=${INPUT}_${RANDOM}.mp4
		settings
		PROGRAM
	done
else
		settings
		PROGRAM

fi
exit 0





#nice -n 19 ffmpeg $1 -ofps 23.976 -oac mp3lame -lameopts abr:br=160 -ovc xvid -xvidencopts bitrate=800 -o $1.mp4

#aspect=<0-3>
#Specify input aspect ratio:
#0: 1:1
#1: 4:3 (default)
#2: 16:9
#3: 2.21:1

#-aspect <ratio> (also see -zoom)
#Override movie aspect ratio, in case aspect information is incorrect or missing in the file being played.
#EXAMPLE:
#-aspect 4:3  or -aspect 1.3333
#-aspect 16:9 or -aspect 1.7777

