#!/bin/ksh

#script to organize files in DVD size folders


NUM=1
EXTENSION=${@:-*}
FILE_NUM=$(ls *.${EXTENSION} | wc -l)
FOLDER=disc
NAME=$(basename $(pwd))
HERM=$(pwd)
SIZE=4447640
#SIZE=600000
#SIZE=80000


mkdir ${NAME}_${FOLDER}_${NUM} > /dev/null

for FILE in $(ls *.${EXTENSION}) ; do 

	echo " $FILE_NUM files left to process"

	mv -v ${FILE} ${NAME}_${FOLDER}_${NUM}/

#	if [ $(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}') -ge 4600000 ] ; then

	if [ $(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}') -ge ${SIZE} ] ; then
	
	#	let DIFF=${SIZE}-$(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}')
		let DIFF=$(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}')-${SIZE}
		
		TRY=1
		
		mv -v ${NAME}_${FOLDER}_${NUM}/${FILE} ./
		
		while [ $(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}') -le ${SIZE} ] && [ $TRY -le 100 ] ; do 
		
			let DIFF2=${SIZE}-$(du -s ${NAME}_${FOLDER}_${NUM} | awk '{print $1}')
			
			FILER1=$(du -s * | grep -v ${NAME}_${FOLDER} | awk '$1 <= "'"$DIFF2"'" { print $NF ; exit; }')
		
			mv -v $FILER1 ${NAME}_${FOLDER}_${NUM}/
			
			[ -z $FILER1 ] && TRY=101
			
			let TRY=$TRY+1
		done
		
					cd ${NAME}_${FOLDER}_${NUM}
	
					while [ $(du -s . | awk '{print $1}') -ge ${SIZE} ] && [ $TRY -le 100 ] ; do
	
						let DIFF3=$(du -s . | awk '{print $1}')-${SIZE}
					
						FILER1=$(du -s * | awk '$1 <= "'"$DIFF3"'" { print $NF ; exit; }')
		
						mv -v $FILER1 ../
			
						[ -z $FILER1 ] && TRY=101
			
						let TRY=$TRY+1
		
					done
		
					cd ${HERM}
		
		let NUM=$NUM+1
		mkdir ${NAME}_${FOLDER}_${NUM} > /dev/null
		mv -v ${FILE} ${NAME}_${FOLDER}_${NUM}/
	fi

	let FILE_NUM=$FILE_NUM-1
done		


#4447640

