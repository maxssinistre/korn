#!/bin/ksh



YOUTUBE=0
WGET=0
KSH=0
PERL=0
SCRIPTS=0
FFMPEG=0


function process {

echo " The date is $(date) "

#ps -ef | egrep '(yout|wget|ksh|\.pl)'
#ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial
ps -ef | egrep ${PROCSEARCH} | grep -v show_spe[c]ial

#echo ${PROCSEARCH}

#TOTAL_PROCS=$(ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial | wc -l)
TOTAL_PROCS=$(ps -ef | egrep ${PROCSEARCH} | grep -v show_spe[c]ial | wc -l)

let LEFT=${LOOP}-1
echo " 
	${TOTAL_PROCS} total processes returned
	${LEFT} iterations left to complete 
	Pausing for ${TIME} seconds .....
"
}

function search_type {

#ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial

if [ ${YOUTUBE} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | grep y[o]ut | grep -v show_spe[c]ial)
        PROCSEARCH=y[o]ut

elif [ ${WGET} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | grep w[g]et | grep -v show_spe[c]ial)
        PROCSEARCH=w[g]et

elif [ ${KSH} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | grep k[s]h | grep -v show_spe[c]ial)
        PROCSEARCH=k[s]h

elif [ ${PERL} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | grep \.[p]l | grep -v show_spe[c]ial)
        PROCSEARCH=\.[p]l

elif [ ${PYTHON} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | grep \.[p]y | grep -v show_spe[c]ial)
        PROCSEARCH=\.[p]y

elif [ ${SCRIPTS} -eq 1 ] ; then

#        PROCSEARCH=$(ps -ef | egrep '(k[s]h|\.[p]l)' | grep -v show_spe[c]ial)
        PROCSEARCH='(k[s]h|\.[p]l|\.[p]y)'

elif [ ${FFMPEG} -eq 1 ] ; then

        PROCSEARCH=ff[m]peg
else

#        PROCSEARCH=$(ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial)
        PROCSEARCH='(v[l]c|y[o]ut|w[g]et|k[s]h|\.[p]l|\.[p]y|ff[m]peg)'

fi

echo ${PROCSEARCH}
}


function countdown {


echo "Start Count"

MIN=1 && for VON in $(seq $(($MIN*${TIME})) -1 1); do 

	echo -n ":${VON}"
	sleep 1
 
done

echo -e "\n\nBOOOM! Time to check processes."


}

function usage {

echo '

	simple utility to show wget, ksh, pl, py, and youtube-dl processes

	-l how many time you want the script to loop, chose 0 for infinite.
	   if no choice made it will run once	
	-h to bring up this usage statement
	-t time between loops in seconds. default is 10 if nothing is choosen
	-s show only perl , python and korn scripts
	-y show only youtube-dl downloads
	-w show only wget
	-k show only korn shell
	-p show only perl scripts
	-P show only python scripts
	-f show ffmpeg instances
 
'
exit 0

}

function forever {

if [ ${LOOPY} -eq 0 ] ; then

	LOOP=20
	echo "forever mode.....you choose zero, didn't you ?"

fi

}



###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts ywkpshfPl:t: option
do
        case $option in
        l) LOOPY="$OPTARG" ;;
        t) TIMEY="$OPTARG" ;;
	y) YOUTUBE=1 ;;
	w) WGET=1 ;;
	k) KSH=1 ;;
	p) PERL=1 ;;
	P) PYTHON=1 ;;
	s) SCRIPTS=1 ;;
	f) FFMPEG=1 ;;
        h) usage;;
        *) usage;;

        esac
done

LOOP=${LOOPY:-1}
TIME=${TIMEY:-10}

shift $(expr $OPTIND - 1)


###########################

forever

search_type

while [ ${LOOP} -ge 1 ] ; do

	process | grep -v plex

	let LOOP=${LOOP}-1

	if [ ${LOOP} -eq 0 ] ; then     
        	echo "no more iterations left"
        	exit 0
	fi


	countdown

	forever

done
