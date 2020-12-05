#!/bin/ksh


TODAY=$(date +%m%d%y%H%M%S)
TEMP_FILE_TNAFLIX=.temp_TNAFLIX
TODAY_OUTPUT_TNAFLIX=searched_TNAFLIX_${TODAY}
COUNT=$@

CONFIG=.temp
PAGE=webpage


#functions
function download_manager {

			while [ $( ps -ef | grep wget | wc -l ) -ge 3 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
}		

function check_names {

		if [ $( ls *.flv | grep ${NAME}.flv | wc -l ) -ge 1 ] ; then
		
			NAME=${NAME}_${RANDOM}
		fi

}


echo "What are you looking for today? "
read SEARCH1

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

DIRP=$(echo ${SEARCH} | cut -c1-24 )

#make directory for download and change to it

mkdir ${DIRP}
cd ${DIRP}
# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 1 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.tnaflix.com/search.php?page=${count}\&what=${SEARCH} -O ${PAGE}_TNAFLIX_${count}			
		
		let count=$count-1
			
		done

#pull links out of downloaded file

cat webpage_TNAFLIX_* | grep -o 'href="[^*]*"' | grep -v http | awk -F '"' '/video/ { print "http://www.tnaflix.com"$2 }' >> ${TODAY_OUTPUT_TNAFLIX}



# download links 



	for T in $(cat ${TODAY_OUTPUT_TNAFLIX} ) ; do 
		echo "searching $T"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O ${TEMP_FILE_TNAFLIX}
		FILE_URL=$(cat ${TEMP_FILE_TNAFLIX} |grep tnaflv2 | grep -v height | cut -d '"' -f2 )
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE_URL} -O ${TEMP_FILE_TNAFLIX}_2
		FILE=$( cat ${TEMP_FILE_TNAFLIX}_2 | grep videoLink | cut -d ">" -f2 |  cut -d "<" -f1)
		NAME=$(cat ${TEMP_FILE_TNAFLIX} | grep "<title>" | cut -d ">" -f2 |  cut -d "," -f1 | sed 's#\ #+#g' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_TNAFLIX} ${TEMP_FILE_TNAFLIX}*




