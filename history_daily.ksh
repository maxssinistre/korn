#!/bin/ksh


DATE=$(date +%Y%m%d%H%M%S)



function usage {

echo "
	simple script to greate folders and download rips for soundcloud accounts. just get the acount name an it's good

		-l put the full link without the number
		-c amount of pages
		-h this help doc
		-? might add something else
"
exit 0
}







###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts hc:l: option
do
        case $option in
        l) LINK="$OPTARG" ;;
	c) COUNT="$OPTARG" ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################


DIR=$(echo ${LINK} | awk -F "/" '{ print $4 }' | tr [:lower:] [:upper:] )

mkdir $DIR

cd $DIR

for NUM in {1..${COUNT}} ; do 

	wget ${LINK}/${NUM} -O ${NUM}.html

done


cat *.html | awk -F "\'" '/gallery-image/ && /img src/ { print "https:"$4 }' > .list_${DATE}.txt


wget -nc -i .list_${DATE}.txt

mkdir HTML

mv -v *.html HTML/

archive.ksh -bd



