#!/bin/ksh


#to get gizmag galleries and put in named folder


###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts hl: option
do
        case $option in
        l) LINK="$OPTARG" ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################


FOLDER=$(echo ${LINK} |  awk -F "/" '{ print $4 }' | tr [:lower:] [:upper:])

HTMLOUT=$(echo $FOLDER | tr [:upper:] [:lower:])

mkdir ${FOLDER} 

cd ${FOLDER}

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${LINK} -O ${HTMLOUT}.html

cat ${HTMLOUT}.html | tr '"' "\n" | awk 'BEGIN{ IGNORECASE=1} ; /jpg|png|jpeg/ && /dpr/ && /960|1000/ && !/Width|400|crop/ { gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' > .list1

wget --no-clobber -i .list1

for T in $(ls | egrep -i '(gif|jpg|png|jpeg)') ; do 

	NEW=$(echo $T | cut -d '?' -f1 ) 

	mv -v $T $NEW 

done

rm *2x




