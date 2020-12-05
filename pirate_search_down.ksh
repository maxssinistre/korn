#!/bin/ksh


function usage {

echo " pirate bay downloader - pull out the magnet links

        -s what to search for - put quotes around it 
        -n amount of pages to pull down 
        -o output file name
	-a automatically add links to deluge

"
exit 0
}

NUM_1=0
TODAY=$(date +%m%d%y%H%M%S)
OUTPUT=piratelinks_${TODAY}.txt
CONFIG_1=.list_${TODAY}
ADD=0




###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts as:n:o: option
do
        case $option in
        s) ANSWER_1="$OPTARG" ;;
        o) OUTPUT_1="$OPTARG" ;;
        n) NUM_2="$OPTARG" ;;
	a) ADD=1 ;;
        *) usage;;

        esac
done


NUM=${NUM_2:-$NUM_1}

ANSWER=$(echo $ANSWER_1 | sed 's#\ #%20#g')
DIR=$(echo $ANSWER | sed 's#%20#+#g')
OUTPUT=${OUTPUT_1:-$CONFIG_1}


echo " the NUM var is $NUM "
echo " the ANSWER var is $ANSWER "
echo " the OUTPUT var is $OUTPUT "

shift $(expr $OPTIND - 1)

##########################################


mkdir ${DIR}
cd ${DIR}

while [ ${NUM} -ge 0 ] ; do

#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://thepiratebay.is/search/${ANSWER}/${NUM} -O - | grep -o 'href="[^*]*"' | grep magnet | cut -d '"' -f2 >> ${OUTPUT}
	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://thepiratebay.se/search/${ANSWER}/${NUM} -O - | grep -o 'href="[^*]*"' | grep magnet | cut -d '"' -f2 >> ${OUTPUT}
	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://thepiratebay.org/search/${ANSWER}/${NUM} -O - | grep -o 'href="[^*]*"' | grep magnet | cut -d '"' -f2 >> ${OUTPUT}

	let NUM=${NUM}-1

done

cat ${OUTPUT} | awk '!a[$0]++' > .temp
mv .temp ${OUTPUT}


if [ ${ADD} -eq 1 ] ; then

	for MAG in $(cat ${OUTPUT} ) ; do

		#echo "deluge-console --config=/var/lib/deluge/.config/deluge "add ${MAG}""

		deluge-console --config=/var/lib/deluge/.config/deluge "add ${MAG}"

	done

fi



#http://thepiratebay.is/search/plumper/0/7/0/

