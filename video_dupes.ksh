#!/bin/ksh

#to find possible duplicate files in a folder

HERM=$(pwd)
TEMP=DUPLICATE_CHECK
DUPE_DIR=DOUBLES2CHECK
DATE=$(date +%Y%m%d%H%M%S)

mkdir -p ${HERM}/$TEMP/$DUPE_DIR
 


function dupydoo {

NUM=0
INPUT=$@

for OTHERS in $(ls *_CHECK | grep -v ${INPUT}) ; do

	if [ $(diff $INPUT $OTHERS | wc -l ) -lt 3 ] ; then

		if [ $(diff $INPUT $OTHERS 2>&1 | grep directory | wc -l ) -ge 1 ] ; then
			echo "dupe alreay moved"
		else
		mv -v ${OTHERS} ${DUPE_DIR}/
		NUM=50
		fi
	
	fi

done	

if [ $NUM -eq 50 ] ; then

	mv -v ${INPUT} ${DUPE_DIR}/

fi

}


for VID in $( ls | egrep -i '(mp|avi|flv|mov)' ) ; do

	OUT=${TEMP}/${VID}_CHECK

	strings $VID | head -30000 | tr -d [:punct:] | tr -d [:cntrl:] | tr -d [:space:] >> $OUT

done


cd $TEMP

for CHECK in $(ls *_CHECK) ; do


	dupydoo $CHECK 

done


cd ${HERM}/$TEMP/$DUPE_DIR

for FILE in $(ls *_CHECK) ; do

	NEW=$(echo ${FILE} | sed 's#_CHECK##g' )
	
	mv -v ${HERM}/${NEW} ${HERM}/${TEMP}/

done


cd ${HERM}/$TEMP


tar -cvzf ARCHIVE_${DATE}.tgz *_CHECK ${DUPE_DIR}

rm -rf *_CHECK ${DUPE_DIR}




		






