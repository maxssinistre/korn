#!/bin/ksh





###########################options
[ $# -lt 1 ] && usage

while getopts i:d:h option
do
      case $option in
                i) IMAGE="${OPTARG}" ;;
                d) DIRECTORY="$OPTARG" ;;
                h) usage;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################



NEW=$(echo $IMAGE | cut -d "." -f 1)
DIR=${DIRECTORY:-$NEW}
#DIR=${NEW}

mkdir -p /mnt/IMAGES/${DIR}

echo "mount -o loop $IMAGE /mnt/IMAGES/${DIR} "

mount -o loop $IMAGE /mnt/IMAGES/${DIR}

echo "don't forget to delete the /mnt/IMAGES/${DIR} when you unmount...."
