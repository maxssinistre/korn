#!/bin/ksh

SOUND=0

function usage {

echo "
	application to mount and look at vids on iso files

	s - what you are searching for , can be a fragment. case doesn\'t matter
	n - choose this to mute output
	o - enclose in quotes any extra options for mplayer as used in my show_today script	
"
exit 0
}

###########################options
[ $# -lt 1 ] && usage


while getopts s:no: option
do
      case $option in
                s) SEARCH="${OPTARG}" ;;
		n) SOUND=1  ;;
		o) OPTIONS="${OPTARG}" ;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################



[ $SOUND -eq 1 ] && HEAR="-n"



SEA=$1
STUFF=$2

        for T in $(ls *.iso) ; do 

                mount -o loop $T /mnt/image1/ 
                show_today.ksh -m -d /mnt/image1 ${HEAR} -e $SEARCH -o "${OPTIONS}"
                umount /mnt/image1 

        done 

