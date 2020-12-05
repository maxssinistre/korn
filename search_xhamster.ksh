#!/bin/ksh


TODAY=$(date +%m%d%y%H%M%S)
TEMP_FILE=.temp
#MYTH_WEBSITE=http://192.168.1.100/mythweb/tv/recorded?sortby=airdate
TODAY_OUTPUT=searched_${TODAY}
COUNT=$@

CONFIG=.temp
PAGE=webpage

echo "What are you looking for today? "
read SEARCH1

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

DIRP=$(echo ${SEARCH} | cut -c1-24 )

#make directory for download and change to it

mkdir ${DIRP}
cd ${DIRP}
# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 1 ]
		do
			#wget http://www.youtube.com/results\?search_type\=search_videos\&search_query\=${SEARCH}\&search_sort\=relevance\&search_category\=0\&page\=${count} -O ${PAGE}_${count}
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://xhamster.com/search.php\?q=${SEARCH}\&page=${count} -O ${PAGE}_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

cat $PAGE_* | grep -o 'href="[^*]*"' | grep movie | cut -d '"' -f2 | sed 's#^#http://xhamster.com#g' | awk '!a[$0]++' >> ${TODAY_OUTPUT}


# download links 



#wget ${MYTH_WEBSITE} -O ${TODAY_OUTPUT}




	for T in $(cat ${TODAY_OUTPUT} ) ; do 
		echo "searching $T"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - |grep -A 4 flashvars > ${TEMP_FILE}
		SERVER=$(grep srv ${TEMP_FILE} | cut -d "'" -f 4 )
		FILE=$(grep file ${TEMP_FILE} | cut -d "'" -f 4 )
		IMAGE=$(grep image ${TEMP_FILE} | cut -d "'" -f 4 )
		echo ${SERVER}
		echo ${FILE}
		echo ${IMAGE}

		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${IMAGE} 		
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${SERVER}/flv2/${FILE} &
		
			while [ $( ps -ef | grep wget | wc -l ) -ge 3 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
		#read
	done


rm ${TODAY_OUTPUT} ${TEMP_FILE}





# http://192.168.1.100/mythweb/tv/recorded?sortby=airdate




#<a class="x-pixmap" href="/mythweb/tv/detail/1055/1291420800" title="Recording Details"

#\<a\ class=\"x-pixmap\"\ href=\"/mythweb/tv/detail/${T}\"\ title=\"Recording\ Details\"


#http://xhamster.com/search.php?q=karla%20lane&page=1

#http://xhamster.com/search.php?q=karla+lane&page=2
