#!/bin/ksh

#bandcamp downloader

SPIDER=0


function usage {

echo 
"
		simple script to download bandcamp albums and catagorize them
		-b band name and folder name
		-s spider to other bancamp sites that are related
		-r for random wait times
"
exit 0

}

function crawling {

INPUT=$1
HERP=$(pwd)


for SPIN in $(cat ${INPUT}) ; do 

	BANDIR=$(echo ${SPIN} | awk -F "/" '{ print $3}' | cut -d "." -f1 | tr [:lower:] [:upper:] )

	mkdir ${BANDIR}
 	cd  ${BANDIR}

	youtube-dl --add-metadata --extract-audio --audio-format mp3 -v -t ${SPIN}

	cd ${HERP}

done 

}


###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts rsb: option
do
	case $option in
		b) BAND="${OPTARG}" ;;
		s) SPIDER=1 ;;
		r) RANDY=1 ;;
        *) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)


if [ ${RANDY} -eq 1 ] ; then

        INTERVAL="--sleep-interval 1 --max-sleep-interval 30"

else

	INTERVAL=""
fi


DIRP=$(echo ${BAND} | tr [:lower:] [:upper:])

mkdir ${DIRP}  

cd ${DIRP}

#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://${BAND}.bandcamp.com -O ${BAND}.html
wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://${BAND}.bandcamp.com/music -O ${BAND}.html

#cat ${BAND}.html  | awk -F '"' '/\/album/ && /href/ && !/http/ { print "https://'"${BAND}"'.bandcamp.com"$2 }' >> ${BAND}_list.txt
cat ${BAND}.html  | tr '"' "\n" | awk -F '"' '/\/album|\/track/ && !/http|href|\&quot/ { print "https://'"${BAND}"'.bandcamp.com"$0 }' >> ${BAND}_list.txt

#cat ${BAND}_list.txt


HERM=$(pwd) 

for ALB in $(cat ${BAND}_list.txt)  ; do 

	NAME=$(echo $ALB | awk -F "/" '{ print $NF }' | tr [:lower:] [:upper:] ) 
	mkdir $NAME 
	cd $NAME 
	youtube-dl ${INTERVAL} --add-metadata --extract-audio --audio-format mp3 -v -t $ALB 
	cd $HERM 

done

#youtube-dl --add-metadata --extract-audio --audio-format mp3 -a ${BAND}_list.txt





#now get the groups that they are also in - spider



#cat ${BAND}.html  | awk -F '"' '/\/album/ && /href/ && /http/ { print $2 }' | awk -F '?' '{ print $1 }' | awk  '!a[$0]++' >> ${BAND}_spider_list.txt
#cat ${BAND}.html  | tr '"' "\n" | awk -F '"' '/\/album/ && !/http/ { print $0 }' | awk -F '?' '{ print $1 }' | awk  '!a[$0]++' >> ${BAND}_spider_list.txt
cat ${BAND}.html | awk '/tab=music/ && !/&quot/ { print $0 }' | awk -F '?' '{ print $1 }' | awk  '!a[$0]++' | cut -d '"' -f2 >> ${BAND}_spider_list.txt

cat ${BAND}_spider_list.txt | cut -d "." -f 1 | awk -F "/" '{ print $NF }' | awk '!a[$0]++' >> ${BAND}_refer_list.txt


if [ ${SPIDER} -eq 1 ] ; then

	mkdir SPIDER
	cd SPIDER 
	crawling ${HERM}/${BAND}_spider_list.txt

fi


