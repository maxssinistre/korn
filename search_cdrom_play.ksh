#!/bin/ksh

SOUND=0
BIGGY=+0

function usage {

echo "
	application to mount and look at vids on iso files

	s - what you are searching for , can be a fragment. case doesn\'t matter
	n - choose this to mute output
	o - enclose in quotes any extra options for mplayer as used in my show_today script	
	B - the size of the file you are looking for
"
exit 0
}

###########################options
[ $# -lt 1 ] && usage


while getopts s:no:B: option
do
      case $option in
                s) SEARCH="${OPTARG}" ;;
		n) SOUND=1  ;;
		o) OPTIONS="${OPTARG}" ;;
		B) BIGGY="${OPTARG}" ;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################



[ $SOUND -eq 1 ] && HEAR="-n"



SEA=$1
STUFF=$2
DEV=0


#for T in $(ls *.iso) ; do 

while true ; do 

                sudo mount /dev/sr${DEV} /mnt/cdrom1/ 
                show_today.ksh -m -d /mnt/cdrom1 ${HEAR} -e $SEARCH -o "${OPTIONS}" -B ${BIGGY}
                sudo umount /mnt/cdrom1
#		eject /dev/sr${DEV}

		        if [ ${DEV} -eq 0 ] ; then

		                DEV=1
		        else

		                DEV=0

		        fi
	echo " ctrl-c to end loop, enter to continure"
	read

        done 

