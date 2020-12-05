#!/bin/ksh 


#application to remove dupes from directories

#will add more switches and crap once this works

TODAY=$(date +%m%d%y%H%M%S)
DUPE_LIST=dupe_list_${TODAY}.txt
DUPE_LIST_OUT=dupe_list_${TODAY}_output.txt
DUPE_TEST_OUT=dupe_list_${TODAY}_test_output.txt
HERE=$(pwd)
TEST=0
RM="/bin/rm -v"

function usage {

echo '

        
	application to remove dupes from directories
	will add more switches and crap once this works

        -d directory you want to start in  --FULL PATH NEEDED IF ELSEWHERE 
        -e extension to look for -- enclose multiples with quotes
	-t test run - just show the files you would delete
	-l process previously created list - use alone and when you are sure - does not take ANY other switches
	-i make the remove command interactive (rm -iv)
        -h to bring up this usage statement
        
'
exit 0

}






function main_list {
echo "creating list"
DIP=$1
MAIN=$2

	fdupes -rf ${DIP}/ > ${DIP}/${MAIN}

}

function parse_extension {
echo "getting only the ones you want"
EXTP=$1
LIST_IN=$2
LIST_OUT=$3

	grep -i ${EXTP} ${LIST_IN} >> ${LIST_OUT}

}

function testy {
RESULT=$1
LISTY=$2
TEST_OUT=$3

	if [ ${RESULT} -eq 1 ] ; then

		echo "this is how i would have done the delete, if i had done it....."
	
		cp -v ${LISTY} ${TEST_OUT} 

		more ${LISTY}

	fi

	if [ ${RESULT} -eq 1 ] ; then
	
		rm ${DIRECTORY_REAL}/${DUPE_LIST_OUT} ${DIRECTORY_REAL}/${DUPE_LIST}

		exit 0 
	fi

}


function process_list {
echo "deleting those found wanting "

LIST=$@

	TOTAL=$(cat ${LIST} | wc -l )

	while [ ${TOTAL} -ge 1 ] ; do 

#		echo ${TOTAL} ${DIP}/${DUPE_LIST}_${EXTP}
		echo "${TOTAL} left to delete ...."

		${RM} "$(sed "${TOTAL}q;d" ${LIST})"

	#	let TOTAL=$TOTAL-1
		TOTAL=$(($TOTAL-1))


	done

}







###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts d:e:l:hti option
do
        case $option in
        d) DIRECTORY="$OPTARG" ;;
        e) EXTENSION="$OPTARG" ;;
        l) PREVIOUS="$OPTARG" ;;        
	t) TEST=1 ;;
	i) RM="/bin/rm -iv" ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)


###########################


if [ ! -z ${PREVIOUS} ] ; then

	process_list ${PREVIOUS}

	exit 0

fi
	

DIRECTORY_REAL=${DIRECTORY:-$(pwd)}

main_list ${DIRECTORY_REAL} ${DUPE_LIST}
 
#parse_extension ${EXTENSION}
for INPUT in ${EXTENSION} ; do 

	parse_extension ${INPUT} ${DIRECTORY_REAL}/${DUPE_LIST} ${DIRECTORY_REAL}/${DUPE_LIST_OUT}

done


testy ${TEST} ${DIRECTORY_REAL}/${DUPE_LIST_OUT} ${DIRECTORY_REAL}/${DUPE_TEST_OUT}

process_list ${DIRECTORY_REAL}/${DUPE_LIST_OUT}


rm ${DIRECTORY_REAL}/${DUPE_LIST_OUT} ${DIRECTORY_REAL}/${DUPE_LIST}
