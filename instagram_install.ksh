#!/bin/ksh






function usage {

echo "
	simple script to greate folders and download rips for instagram accounts. just get the acount name an it's good

		-i instagram accound name ex https://instagram.com/taygray1991/ becomes taygray1991
		-h this help doc
		-? might add something else
"
}







###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts hai: option
do
        case $option in
        i) INSTAGRAM="$OPTARG" ;;
	a) ARCHIVE=1 ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################


GENERIC_BLOG_LOCATION=/mnt/drive1/GENERIC/INSTAGRAM
#GENERIC_BLOG_LOCATION=/mnt/NASSER/drive1/GENERIC/INSTAGRAM



HERM=$(pwd)





	FOLDER=$(echo $INSTAGRAM | tr [:lower:] [:upper:])

	mkdir $FOLDER

	cd $FOLDER

	#cp -v /mnt/drive1/GENERIC/INSTAGRAM/* ./

	cat ${GENERIC_BLOG_LOCATION}/generic_instagram.ksh | sed "s#GENERICINSTAGRAM#${INSTAGRAM}#g" > ${INSTAGRAM}_instagram.ksh

	#rm generic_instagram.ksh

	
	ksh ${INSTAGRAM}_instagram.ksh

	cd ${HERM}


function original {




mkdir PICS/SMALL
cd PICS

youtube-dl -i -v -t --write-pages http://instagram.com/mulhermelanciaoficial/
youtube-dl -i -v -t --write-pages http://instagram.com/melanciamulher/


archive.ksh -ud -f SMALL*

#cat *.dump | tr '"' "\n" | egrep -i '(gif|jpg|jpeg)' | awk '{ gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' >> index_list
#cat *.dump | tr '"' "\n" | awk 'BEGIN {IGNORECASE = 1} /gif/ || /jpg/ || /jpeg/ && !/s[0-9][0-9][0-9]x[0-9][0-9][0-9]/ { gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' >> index_list

#cat *.dump | tr '"' "\n" | awk 'BEGIN {IGNORECASE = 1} /gif/ || /jpg/ || /jpeg/ { gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | grep -v s[0-9][0-9][0-9]x[0-9][0-9][0-9] | awk '!a[$0]++' >> index_list
#big pics
cat *.dump | tr '"' "\n" | awk 'BEGIN {IGNORECASE = 1} (/gif/ || /jpg/ || /jpeg/) && !/s[0-9][0-9][0-9]x[0-9][0-9][0-9]/ && !/_a/ && !/profile/ { gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' >> index_list

#vids
cat *.dump | tr '"' "\n" | awk 'BEGIN {IGNORECASE = 1} /mp4/ || /flv/ || /webm/ { gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' >> index_list



#small pics
cat *.dump | tr '"' "\n" | awk 'BEGIN {IGNORECASE = 1} (/gif/ || /jpg/ || /jpeg/) && !/s[0-9][0-9][0-9]x[0-9][0-9][0-9]/ && /_a/ || /profile/ { gsub ("https","http") ; gsub ("\\\\/","/") ; print $0 }' | awk '!a[$0]++' >> SMALL/index_list

rm *.dump

wget -nc -i index_list

> index_list

cd SMALL

wget -nc -i index_list

> index_list

cd ../

archive.ksh -td -f SMALL


}
