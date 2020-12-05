#!/bin/ksh


FASTPEOPLE="https://www.fastpeoplesearch.com/address/"
REHOLD="https://rehold.com/"
THATSTHEM="https://thatsthem.com/address/"

FAST=0
REH=0
THATS=0
ALL=0

#TEMP_FILE=.temp_$RANDOM
#TEMP_FILE_2=.temp_$RANDOM


function usage {
	echo "
	
	This is a script for searching several reverse searches at once
		-R choose this to search rehold.com
		-F choose this to search fastpeoplesearch.com
		-T choose this to search thatsthem.com
		-n the house number to search
		-r the road to search
		-t the town to search
		-s the state to search , defaults to delaware - you don't have to input if delaware
		-i a formated input file to arse through. Foramted as follows :
		
		House Number|Road|Town|State
		
		the format is pipe delimited no spaces between pipe
		
"
exit 0
}


function wget_command { 
WEBSIRE=$1
TEMP_OUT=$2

#WAIT=$(( $RANDOM %60 + 1))
WAIT=$(( $RANDOM %6 + 1))
##echo "waiting ${WAIT} seconds ... "
sleep $WAIT

wget -O $TEMP_OUT --random-wait --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $WEBSIRE 2> /dev/null

}

function peoplesearch {

HOUSE_NUMBER_FP=${1}
ROAD_FP=$(echo ${2} | sed 's#=#-#g' )
TOWN_FP=$(echo ${3} | sed 's#=#-#g' )
STATE_FP=${4}

SEARCH_FP=${HOUSE_NUMBER_FP}-${ROAD_FP}_${TOWN_FP}-${STATE_FP}

366-paul-drive_smyrna-de

#FAST=$1
TEMP_FILE=.temp_$RANDOM

echo "wget_command ${FASTPEOPLE}${SEARCH_FP} ${TEMP_FILE}"
wget_command ${FASTPEOPLE}${SEARCH_FP} ${TEMP_FILE}

PERSON_FULL="$(cat ${TEMP_FILE} | awk -F "\'" '{IGNORECASE=1} ; /recent tenant/ && /strong/ && !/Search public records on/ { gsub("FastPeopleSearch for ","") ; print $4 }' | awk '!a[$0]++')"


PERSON_PARSE="$(echo ${PERSON_FULL} | awk '{ print $1 }' )"
echo ${PERSON_FULL}

PHONE_NUMBER="$(cat ${TEMP_FILE} | grep -i -A 35 "${PERSON_PARSE}" | awk -F '"' '{IGNORECASE=1} ; /phone number/ && /strong/ { print $4 }' | head -2 | awk '!a[$0]++') "

echo ${PHONE_NUMBER}

rm ${TEMP_FILE}

}

function rehold {

HOUSE_NUMBER_RH=${1}
ROAD_RH=$(echo ${2} | sed 's#=#+#g' )
TOWN_RH=$(echo ${3} | sed 's#=#+#g' )
STATE_RH=${4}

SEARCH_RH=${TOWN_RH}+${STATE_RH}/${ROAD_RH}/${HOUSE_NUMBER} 

#FAST=$1
TEMP_FILE=.temp_$RANDOM

echo "working REHOLD ${SEARCH_RH} ....."

wget_command ${REHOLD}${SEARCH_RH} ${TEMP_FILE}



PERSON_FULL="$(cat ${TEMP_FILE} | awk '{ IGNORECASE=1 } ; /data-original-title|HOUSE_NUMBER-phone/ { print $0 } ' | grep -i -B 1 HOUSE_NUMBER-phone | awk '!a[$0]++')"

#echo ${PERSON_FULL}

#PERSON_PARSE_1="$(echo ${PERSON_FULL} | awk -F '"' '/glyphicon-user/ { print $NF }' | head -1)"
#PERSON_PARSE_2="$(echo ${PERSON_FULL} | awk -F '"' '/glyphicon-user/ { print $NF }' | tail -1)"

PERSON_PARSE_1="$(echo ${PERSON_FULL} | awk -F '"' '/glyphicon-user/ { print $15 }' | awk '{ print $1,$2,$3 }' | sed 's#></i>##g' | sed 's#</a>##g' | sed 's#</span></td><td##g' )"

PERSON_PARSE_2="$(echo ${PERSON_FULL} | awk -F '"' '/glyphicon-user/ { print $39 }' | awk '{ print $1,$2,$3 }' | sed 's#></i>##g' | sed 's#</a>##g' | sed 's# </span></td><td##g' | sed 's#,$##g' )"

PHONE_NUMBER_1=$(echo ${PERSON_FULL} | tr '"' "\n" | awk -F '"' '/HOUSE_NUMBER-phone/  { print $0 }' | awk -F "-" '{ gsub("phone/","") ; print $2 }' | head -1 )
PHONE_NUMBER_2=$(echo ${PERSON_FULL} | tr '"' "\n" | awk -F '"' '/HOUSE_NUMBER-phone/  { print $0 }' | awk -F "-" '{ gsub("phone/","") ; print $2 }' | tail -1 )

##echo " ${PERSON_PARSE_1} - ${PHONE_NUMBER_1} "
##echo " ${PERSON_PARSE_2} - ${PHONE_NUMBER_2} "


rm ${TEMP_FILE}

}

function thatsthem {

HOUSE_NUMBER_TT=${1}
ROAD_TT=$(echo ${2} | sed 's#=#-#g' )
TOWN_TT=$(echo ${3} | sed 's#=#-#g' )
STATE_TT=${4}

SEARCHY=${HOUSE_NUMBER_TT}-${ROAD_TT}-${TOWN_TT}-${STATE_TT}
#FAST=$1
TEMP_FILE=.temp_$RANDOM

echo "working THATSTHEM ${SEARCHY} ....."

wget_command ${THATSTHEM}${SEARCHY} ${TEMP_FILE}

PERSON_PARSE_1="$(cat ${TEMP_FILE} | awk -F '/' '/name/ && /href/ { gsub("-"," ") ; print $NF }' | sed 's#">##g' | head -1 | sed 's#\n##g'  )"

PERSON_PARSE_2="$(cat ${TEMP_FILE} | awk -F '/' '/name/ && /href/ { gsub("-"," ") ; print $NF }' | sed 's#">##g' | tail -1 | sed 's#\n##g'  )"

#PERSON_PARSE_1="$(cat ${TEMP_FILE} | awk -F '/' '/name/ && /href/ { gsub("-"," ") ; print $NF }' | sed 's#">##g' | head -1 | tr -dc '[:alnum:]\n\r' )"

#PERSON_PARSE_2="$(cat ${TEMP_FILE} | awk -F '/' '/name/ && /href/ { gsub("-"," ") ; print $NF }' | sed 's#">##g' | tail -1 | tr -dc '[:alnum:]\n\r' )"

PHONE_NUMBER_1="$(cat ${TEMP_FILE} | awk -F '/' '/\/phone/ && /href/ { print $NF }' | awk -F '"' '{ print $1 }' | head -1 | sed 's#\n##g' )"

PHONE_NUMBER_2="$(cat ${TEMP_FILE} | awk -F '/' '/\/phone/ && /href/ { print $NF }' | awk -F '"' '{ print $1 }' | tail -1 | sed 's#\n##g' )"

LINE1=${PERSON_PARSE_1}-${PHONE_NUMBER_1} 
LINE2=${PERSON_PARSE_2}-${PHONE_NUMBER_2}

echo ${PERSON_PARSE_1} 
echo ${PHONE_NUMBER_1} 
echo ${PERSON_PARSE_2} 
echo ${PHONE_NUMBER_2} 


rm ${TEMP_FILE}

}

function parse_list {

FILE=$1

cat $FILE | while read linein
   do
	## get variables
	##echo "$linein "
	
	HOUSE_NUMBER="$(echo $linein | awk -F "|" '{ print $1 }')"
	ROAD="$(echo $linein | awk -F "|" '{ print $2 }' | sed 's# #=#g')"
	TOWN="$(echo $linein | awk -F "|" '{ print $3 }' | sed 's# #=#g')"
	STATE="$(echo $linein | awk -F "|" '{ print $4 }' )"
	
	echo $HOUSE_NUMBER $ROAD $TOWN $STATE
	
	echo "========================================================="
	
	all_dem ${HOUSE_NUMBER} ${ROAD} ${TOWN} ${STATE}
	
	SLEEP=$(( $RANDOM %6 + 1))
#	echo "waiting ${SLEEP} seconds ... "
	sleep $SLEEP
	
   done 

}

function zip_code {

SMYRNA=19977
CLAYTON=19938
TOWNSEND=19734

NORTHSIDE_BLACKBIRD=19734
NORTHSIDE_BLACKBIRD=19977
WOODLAND_BEACH=19977
KENTON=19938

}

function all_dem {

peoplesearch ${1} ${2} ${3} ${4} 2> /dev/null 
rehold ${1} ${2} ${3} ${4} 2> /dev/null 
thatsthem ${1} ${2} ${3} ${4} 2> /dev/null 

}

###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts ARFTn:r:t:s:i: option
do
        case $option in
        R) REH=1 ;;
        F) FAST=1 ;;
        T) THATS=1 ;;
        A) ALL=1 ;;
        n) HOUSE_NUMBER="$OPTARG" ;;
        r) ROADY="$OPTARG" ;;
        t) TOWNY="$OPTARG" ;;
        s) STATELY="$OPTARG" ;;
        i) INPUTFILE="$OPTARG" ;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################



#HOUSE_NUMBER=$(echo $STRING1 | tr " " "-")
#TOWN=$STRING2
STATE=${STATELY:-de}
ROAD=$(echo ${ROADY} | sed 's# #=#g' )
TOWN=$(echo ${TOWNY} | sed 's# #=#g' )




if  [[ ${INPUTFILE} != "" ]] ; then

	##echo "do somethinig"

	parse_list ${INPUTFILE}

	##echo "all done"
	exit 0	
	
fi


if [ $ALL -eq 1 ] ; then

	##echo "  running all searches "

	all_dem ${HOUSE_NUMBER} ${ROAD} ${TOWN} ${STATE}
        
elif [ $REH -eq 1 ] ; then

	##echo "  running rehold "

        rehold ${HOUSE_NUMBER} ${ROAD} ${TOWN} ${STATE} 2> /dev/null
        
elif [ $THATS -eq 1 ] ; then

	##echo "  running thatsthem "

        thatsthem ${HOUSE_NUMBER} ${ROAD} ${TOWN} ${STATE} 2> /dev/null
        
elif [ $FAST -eq 1 ] ; then

	##echo "  running fastpeoplesearch "
        peoplesearch ${HOUSE_NUMBER} ${ROAD} ${TOWN} ${STATE} 2> /dev/null
        
fi




##SEARCH=${HOUSE_NUMBER}-${ROAD}_${TOWN}-${STATE}

##411-North-High-Street-Ext-Smyrna-DE








#cat 1465-millington-road_clayton-de | awk -F "\'" '{IGNORECASE=1} ; /recent tenant/ && /strong/ { print $4 }'

#cat 1465-millington-road_clayton-de | awk -F '"' '{IGNORECASE=1} ; /phone number/ && /strong/ { print $0 }'


#https://www.fastpeoplesearch.com/HOUSE_NUMBER/1465-millington-road_clayton-de
