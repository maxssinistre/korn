#!/bin/ksh


function usage {
echo "
a simple script with some preset variables for divx encoding of video files

	-I interactive, i have the questions, you have the answers
	-i input file name
	-o output file name (optional, if you dont't put anthing here it will name the file the same as the input file with a random number and .avi appended) . Do not use in batch mode.
	-v video bitrate
	-a audio bitrate
	-p chose single pass encoding (default, fast larger file) or 2 pass encoding (slower but better quality, smaller file) . Use the number 1 or 2 to denote which you want or don't put anything in and 1 pass will be used
	-B batch mode. Convert all files in the directory that have the extension .nuv .avi .mpeg .mpg .flv (Upper or Lowercase) . Will also look for file that start with Flash. Disables custom fie naming and uses defaults.
	-h this usage blurb
	-A This is for the aspect ratio of the output movie.
		aspect=<0-3>
		Specify input aspect ratio:
		0: 1:1
		1: 4:3 (default)
		2: 16:9
		3: 2.21:1
	-G Automatically get the settings from the file and copy those ( bitrate, color depth, size , aspect , etc)
	-r choose this to repair a file **you will need space to decompress the video of the file(like 30GB for 1/2 hour at medium quality)
	-t for subtitle track to choose ( default is track 2000, as in no subtitles, this is the default )
	-l choose the language track - eng is the default
"
exit 0
}

function get_settings {

#INPUT2=$@

#OUTPUT=${INPUT}_testing.avi

TEMP_CONFIG=.test_$RANDOM

TEMP_CONFIG_1=.test1_$RANDOM

TEMP_CONFIG_2=.test2_$RANDOM

mplayer -v -vo null -ao null -identify -frames 0 ${INPUT} >> ${TEMP_CONFIG}

grep ^ID ${TEMP_CONFIG} >> ${TEMP_CONFIG_1}

tcprobe -i ${INPUT} >> ${TEMP_CONFIG_2}

tcprobe -X -i ${INPUT} >> ${TEMP_CONFIG_2} 

ffmpeg -i ${INPUT} >> ${TEMP_CONFIG_2} 2>&1

.  ./${TEMP_CONFIG_1}

ASPECT_TEMP=$(grep "aspect ratio" ${TEMP_CONFIG_2} | awk '{ print $3 }')

ASPECT=${ASPECT_TEMP:-4:3}

V_BIT_TEMP=$(grep VIDEO: ${TEMP_CONFIG} | awk '{ print $7 }' | cut -d "." -f1)

	if [ ${V_BIT_TEMP} -gt 0 ] ; then
		V_BIT=${V_BIT_TEMP}
			if [ ${V_BIT} -gt 3000 ] ; then 
			PASS_TEMP=2
			fi
	else
		MOVIE_LENGTH_TEMP=$(grep -o 'Duration:[^*]*,' ${TEMP_CONFIG_2} | cut -d " " -f2 | tr -d ",")
		HR=$(echo ${MOVIE_LENGTH_TEMP} | cut -d ":" -f1 )
		MIN=$(echo ${MOVIE_LENGTH_TEMP} | cut -d ":" -f2 )
		HR_SEC=$((${HR}*3600))
		MIN_SEC=$((${MIN}*60)) 
		SEC_SEC=$(echo ${MOVIE_LENGTH_TEMP} | cut -d ":" -f3 | cut -d "." -f1 )
		MOVIE_LENGTH=$((${HR_SEC}+${MIN_SEC}+${SEC_SEC}))
		MOVIE_SIZE=$(grep "File size" ${TEMP_CONFIG} | cut -d " " -f5)
		#MOVIE_SIZE=$((${MOVIE_SIZE_TEMP}/10))
		#V_BIT_TEMP1=$((${MOVIE_LENGTH}/${MOVIE_SIZE}))
		V_BIT_TEMP1=$((${MOVIE_SIZE}/${MOVIE_LENGTH}))
		V_BIT=$(echo ${V_BIT_TEMP1} | sed 's#-##g' )
			if [ ${V_BIT} -gt 3000 ] ; then 
				PASS=2
			elif [ ${V_BIT} -lt 100 ] ;then
				V_BIT=2000
			fi
	fi


A_BIT=$(echo ${ID_AUDIO_BITRATE} | cut -c 1,2,3)

#AUTO_SWITCHES="-ofps ${FPS} -palette ${PALETTE} -oac mp3lame -scale ${V_SIZE_SCALE} -lameopts abr:br=${AA_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT}"
#AUTO_SWITCHES="-ofps ${FPS} -oac mp3lame -lameopts abr:br=${AA_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT} -vf scale=${V_SIZE_X}:${V_SIZE_Y}"
SWITCHES="-ofps ${ID_VIDEO_FPS} -alang ${LANG} -slang ${LANG} -oac mp3lame -lameopts abr:br=${A_BIT} -sid ${SUBTRACK} -ovc xvid -vf scale=${ID_VIDEO_WIDTH}:${ID_VIDEO_HEIGHT} -force-avi-aspect ${ASPECT} -xvidencopts bitrate=${V_BIT}"


#nice -n 19 mencoder ${INPUT} ${AUTO_SWITCHES} -o ${OUTPUT}


rm -v ${TEMP_CONFIG} 
rm -v ${TEMP_CONFIG_1}
rm -v ${TEMP_CONFIG_2}

}

function single_pass {

#nice -n 19 mencoder ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT} -o ${OUTPUT}
nice -n 19 mencoder ${INPUT} ${SWITCHES} -o ${OUTPUT}

}

function two_pass {

#PASS1="-turbo ${SWITCHES}:pass=1"
PASS1="${SWITCHES}:pass=1"
PASS2="${SWITCHES}:pass=2"

#nice -n 19 mencoder ${INPUT} -turbo -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=1:bitrate=${V_BIT} -o /dev/null
nice -n 19 mencoder ${INPUT} ${PASS1} -o /dev/null


#nice -n 19 mencoder ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=2:bitrate=${V_BIT} -o ${OUTPUT}
nice -n 19 mencoder ${INPUT} ${PASS2} -o ${OUTPUT}

}

function repair {

	PASS1="${SWITCHES}:pass=1"
	PASS2="${SWITCHES}:pass=2"

	mencoder ${INPUT} -oac pcm -ovc raw -o output.avi
#	mencoder ${INPUT} -oac pcm -ovc raw -sid -o output.avi

#	mencoder -idx output_1.avi -ovc copy -oac copy -o output.avi

#	rm output_1.avi

#	divx_encode.ksh -i output.avi -o ${OUTPUT}.fixed.avi

if [ ${PASS} -eq 2 ]
	then
	
		nice -n 19 mencoder output.avi ${PASS1} -o /dev/null

		nice -n 19 mencoder output.avi ${PASS2} -o ${OUTPUT}
	else

		nice -n 19 mencoder output.avi ${SWITCHES} -o ${OUTPUT}

fi

	nice -n 19 mencoder -idx ${INPUT} -ovc copy -fafmttag -oac copy -o ${OUTPUT}.fixed.avi

#        nice -n 19 mencoder -idx output.avi -ovc copy -oac copy -o output.2

#	rm output.*

#	nice -n 19 mencoder output.2 ${SWITCHES} -o ${OUTPUT}.fixed2.avi

	rm output.*
	
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


echo "please give the full path of the output file , you can just press enter an you wil get a file with the same name but with a random number and avi appended to it"
read OUTPUT_TEMP

OUTPUT=${OUTPUT_TEMP:-${INPUT}_${RANDOM}.avi}


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
SWITCHES="-ofps 29.97 -oac mp3lame -alang ${LANG} -slang ${LANG} -sid ${SUBTRACK} -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT}:autoaspect=${ASPECT}"

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

echo $@

	while getopts :v:a:i:o:Ip:BrGA:t:l: option
	do
        	case $option in
			v) VBIT=${OPTARG} ;;
			a) ABIT=${OPTARG} ;;
			p) PASS_TEMP=${OPTARG} ;;
			I) INTERACT=1 ;;
			i) INPUT=${OPTARG} ;;
			o) OUTPUT_TEMP=${OPTARG} ;;
			B) BATCH=1 ;;
#			x) X_AXIS=${OPTARG} ;;
#			y) Y_AXIS=${OPTARG} ;;
			G) SETTINGS=1 ;;
			A) A_SPECT=${OPTARG} ;;
			r) REPAIR=1 ;;
			t) SUBTRACK=${OPTARG} ;;
			l) LANG=${OPTARG} ;;
			*) usage;;
	esac
	done
shift $(expr $OPTIND - 1)

OUTPUT=${OUTPUT_TEMP:-${INPUT}_${RANDOM}.avi}
PASS=${PASS_TEMP:-1}

while [[ ${PASS} -gt 2 || ${PASS} -lt 1 ]] ; do

        echo " Please enter 1 or 2 numbnuts"
	        read PASS

		done

A_BIT=${ABIT:-160}
V_BIT=${VBIT:-900}
SUBTRACK=${SUBTRACK:-2000}
LANG=${LANG:-eng}

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
	for FILE in $(ls | egrep -i '(.mp4|.m4a|.mov|.mkv|.wmv|.nuv|.avi|.mpg|.mpeg|Flash|.flv|.3gp)') 
	do	
		INPUT=${FILE}
		OUTPUT=${INPUT}_${RANDOM}.avi
		settings
		PROGRAM
	done
else
		settings
		PROGRAM

fi
exit 0





#nice -n 19 mencoder $1 -ofps 23.976 -oac mp3lame -lameopts abr:br=160 -ovc xvid -xvidencopts bitrate=800 -o $1.avi

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

