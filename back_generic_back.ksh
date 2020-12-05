#!/bin/ksh

CYCLE=0
RANDY=0

function usage {
echo "
	for displaying pics in a directory, either randon singular or cycling through them.
	-d the directory you want to start in. nothing entered $(pwd) will be used (pwd)
	-c choose if you want to cycle through a directory
	-r select if you want to cycle through chosen folder randomly
	-t the time you will spend on each displaying each file in the directory
	-f to choose a particular file - full path may be needed at times
	-k kill automatic cycling through directory
"
exit 0

}

function single {

xv -root -maxpect -random -quit -smooth *

exit 0
}

function many {

TIMER=$1
RANDOMNESS=$2
COMMAND='/usr/bin/xv -maxpect -root -quit'

echo 

if [ ${RANDOMNESS} -eq 0 ] ; then

	for T in $(ls | grep -i jpg) ; do 

        	${COMMAND} $T 
        	sleep ${TIMER} 

	done

elif [ ${RANDOMNESS} -eq 1 ] ; then

	for T in $(ls | grep -i jpg | shuf) ; do 

        	${COMMAND} $T 
        	sleep ${TIMER} 

	done

fi

exit 0
}

function killer {

echo " killing process(s)
$( ps -ef | awk '/back_gen[e]ric_back/ { print $0 }' )
stopping automated scrolling through $( ps -ef | awk '/back_gen[e]ric_back/ { print $NF }' ) directory "

kill $( ps -ef | awk '/back_gen[e]ric_back/ { print $2 }' )

exit 0
}

###########################options
[ $# -lt 1 ] && usage

echo $@

while getopts :d:t:crkf: option
do
        case $option in
        d) DDIR="$OPTARG" ;;
        c) CYCLE=1 ;;
        r) RANDY=1 ;;
        k) killer ;;
        t) TIMEt="$OPTARG" ;;
        f) FILE_TEM="$OPTARG" ;;
        *) usage;;

        esac
done

DIR=${DDIR:-$(pwd)}

TIME=${TIMEt:-60}


cd ${DIR}

if [ $CYCLE -eq 0 ] ; then

	single

elif [ $CYCLE -eq 1 ] ; then

	many $TIME $RANDY

elif [ -n $FILE_TEM ] ; then

	xv -maxpect -root -quit $FILE_TEM

fi

fi
