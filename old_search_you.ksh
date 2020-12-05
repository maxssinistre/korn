#!/bin/ksh


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

count=5
      	
		while [ ${count} -ge 0 ]
		do
			wget http://www.youtube.com/results\?search_type\=search_videos\&search_query\=${SEARCH}\&search_sort\=relevance\&search_category\=0\&page\=${count} -O ${PAGE}_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

cat $PAGE_* | grep watch | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep -v recently_watched | grep watch | sed 's#^#http://www.youtube.com#g' |grep -v all >> ${CONFIG}


# download links


function get_vids {

TEMP_FILE=.temp_$RANDOM

URL=$@

wget -O - "${URL}" 2> /dev/null >> $TEMP_FILE

#SIGNATURE=$(cat ${TEMP_FILE} | grep -o 'signature=[^*&]*' | sed 's#signature=##g')

#REAL_NAME=$(cat ${TEMP_FILE}  | grep fs=1\&title | cut -d '"' -f 4 | tr -d "%20" | tr -d [:punct:] | tr -d [:cntrl:] | sed 's#\ #_#g' | sed 's#__#_#g'| sed 's#^_##g' | tr -d [:space:])
#REAL_NAME=$(cat ${TEMP_FILE} | grep -o '\&title=[^*]*' | cut -d '=' -f 2| cut -d "'" -f1 | tr -d "%20" | tr -d [:punct:] | tr -d [:cntrl:] | sed 's#\ #_#g' | sed 's#__#_#g'| sed 's#^_##g' | tr -d [:space:])
REAL_NAME=$(cat ${TEMP_FILE} | grep -o 'xml\"\ title=[^*]*' | cut -d '=' -f 2| cut -d "'" -f1 | tr -d "%20" | tr -d [:punct:] | tr -d [:cntrl:] | sed 's#\ #_#g' | sed 's#__#_#g'| sed 's#^_##g' | sed 's#_$##g' | tr -d [:space:])

#DOWNLOAD_NAME=$(cat ${TEMP_FILE} | grep fullscreen | cut -d \" -f 2 | cut -d \? -f2| head -1)
#DOWNLOAD_NAME=$(cat ${TEMP_FILE} | grep -o 'SourceURL=http[^*;]*' | cut -d "/" -f4 | sed 's#&amp##g' | sed 's#watch%3Fv%3D##g')
DOWNLOAD_NAME=$(cat ${TEMP_FILE} | grep signature | head -1 | cut -d "'" -f2 | sed 's#generate_204#videoplayback#g')

#FILE_NAME=get_video\?video_id${DOWNLOAD_NAME}

#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youtube.com/get_video?${DOWNLOAD_NAME} -O ${REAL_NAME}.flv
#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://cache.googlevideo.com/get_video?video_id=${DOWNLOAD_NAME} -O ${REAL_NAME}.flv
wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${DOWNLOAD_NAME} -O ${REAL_NAME}.flv
#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youtube.com/get_video?video_id=${DOWNLOAD_NAME}\&t=${SIGNATURE}\&fmt=18 -O ${REAL_NAME}.flv
#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youtube.com/get_video?fmt=18\&amp\;video_id=${DOWNLOAD_NAME}\&amp\;t=${SIGNATURE} -O ${REAL_NAME}.flv

#http://www.youtube.com/get_video?video_id=ID&t=SIGNATURE&fmt=18
#http://www.youtube.com/get_video?fmt=18&amp;video_id='+video_id+'&amp;t='+video_hash+'\'

#mv -v *$(echo ${FILE_NAME} | cut -d '=' -f4 | cut -d '&' -f1)* ${REAL_NAME}.flv

rm $TEMP_FILE 

}

for FLV in $(cat ${CONFIG}) ;
do
		get_vids ${FLV}
		echo "filename is $FILE_NAME"
		echo "real name is $REAL_NAME"
		echo "download nam iis $DOWNLOAD_NAME"
done


# archive results files

tar -cvzf results_$RANDOM.tgz ${PAGE}_* .temp*

rm -f ${PAGE}_* .temp*


echo "your movie files are in the ${DIRP} directory"



