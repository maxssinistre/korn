#!/bin/ksh


SITE=$@
NUM=1
ARCHIVE_FOLDER=ARCV
FLODER_NAME=$(echo $SITE | sed 's#www##g' | cut -d "."  -f 1 | sed 's#http://##g' | tr [:lower:] [:upper:] )

mkdir ${FLODER_NAME}
cd ${FLODER_NAME} > /dev/null

wget ${SITE} -O index_${NUM}.html

mkdir ${ARCHIVE_FOLDER} > /dev/null



while [ $(grep Older index_${NUM}.html | wc -l ) -ge 1 ] ; do
	
	wget $(grep Older index_${NUM}.html | cut -d "'" -f4 ) -O temp
	mv index_${NUM}.html ${ARCHIVE_FOLDER}/
	let NUM=${NUM}+1
	mv temp index_${NUM}.html
	
done

#mv index_${NUM}.html ${ARCHIVE_FOLDER}/

mv ${ARCHIVE_FOLDER}/* ./

rm -rf ${ARCHIVE_FOLDER}