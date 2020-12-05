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

"
exit 0
}

function single_pass {

nice -n 19 mencoder ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts bitrate=${V_BIT} -o ${OUTPUT}

}

function two_pass {

nice -n 19 mencoder ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=1:bitrate=${V_BIT} -o /dev/null


nice -n 19 mencoder ${INPUT} -ofps 23.976 -oac mp3lame -lameopts abr:br=${A_BIT} -ovc xvid -xvidencopts pass=2:bitrate=${V_BIT} -o ${OUTPUT}

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

if [ ${INTERACT} -eq 1 ]
then
	interactive

fi


if [ ${PASS} -eq 2 ]  
then
	two_pass

else
	single_pass

fi

}
     


######################VARIABLES#############################

[ $# -lt 1 ] && usage

INTERACT=0
BATCH=0

echo $@

	while getopts :v:a:i:o:Ip:B option
	do
        	case $option in
			v) VBIT=${OPTARG} ;;
			a) ABIT=${OPTARG} ;;
			p) PASS_TEMP=${OPTARG} ;;
			I) INTERACT=1 ;;
			i) INPUT=${OPTARG} ;;
			o) OUTPUT_TEMP=${OPTARG} ;;
			B) BATCH=1 ;;
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


A_BIT=${ABIT:-128}
V_BIT=${VBIT:-800}

#if [[ -z $INPUT ]] && [[ $INTERACT -eq 0 ]];then
if [[ -z $INPUT && $INTERACT -eq 0 && $BATCH -eq 0 ]];then
        echo " you forgot to put in an input file name"
	usage
fi



######################PROGRAM#############################



if [ $BATCH -eq 1 ] 
then
	OUTPUT=""
	for FILE in $(ls | egrep -i '(.mp4|.wmv|.mkv|.nuv|.avi|.mpg|.mpeg|Flash|.flv)') 
	do	
		INPUT=${FILE}
		OUTPUT=${INPUT}_${RANDOM}.avi
		PROGRAM
	done
else

		PROGRAM

fi
exit 0





#nice -n 19 mencoder $1 -ofps 23.976 -oac mp3lame -lameopts abr:br=160 -ovc xvid -xvidencopts bitrate=800 -o $1.avi
