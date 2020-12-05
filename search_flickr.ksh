#!/bin/ksh


#flickr image search useing flickr hive mind

LIST=.list_$(date +%M%S)
LIST2=.list2_$(date +%M%S)
PER_PAGE=500
PIC_SIZE=1000
ARCHIVE_DIR=archve
ARCHIVE_FILE=archive_$(date +%M%S).tar
PIC_DIR=PICS

#per page variable adjust how many pics will be on a page - can drastically affect how much comes down

echo " What images do you wish to search for ?"
read SEARCH_TEMP

SEARCH_DIR=$(echo ${SEARCH_TEMP} | sed 's#\ #\_#g')
SEARCH_QUERY=$(echo ${SEARCH_TEMP} | sed 's#\ #\+#g')

#create necessary directories

mkdir ${SEARCH_DIR}

mkdir ./${SEARCH_DIR}/${PIC_DIR}

mkdir ./${SEARCH_DIR}/${ARCHIVE_DIR} 

cd ${SEARCH_DIR}

#download search pages - change NUM value to modify how many search pages to pull down

NUM=3

while [ $NUM -ge 0 ] ; do 

#	wget http://www.life.com/search/?q0=${SEARCH_QUERY}\&x=0\&y=${NUM} -O index_${NUM}.html
#	wget http://www.life.com/search/?type=images\&itemsperpage=${PER_PAGE}\&q0=${SEARCH_QUERY}\&page=${NUM} -O index_${NUM}.html
	wget --user-agent=Mozilla http://flickrhivemind.net/flickr_hvmnd.cgi?method=GET\&sorting=Interestingness\&page=${NUM}\&photo_type=${PIC_SIZE}\&noform=t\&search_domain=Tags\&photo_number=${PER_PAGE}\&tag_mode=all\&quicksearch=1\&sort=Interestingness\&textinput=${SEARCH_QUERY}\&search_type=Tags
	let NUM=$NUM-1
done

#pull pic links out of picture pages

cat flickr_hvmnd.cgi* | grep src | grep jpg >> ${LIST}

cat ${LIST} | while read linein ; do 

	PIC_LINK=$(echo ${linein} | grep -o 'src="[^*]*"' | cut -d '"' -f2 | sed 's#\ #/#g')
	DOWNLOAD_NAME=$(echo ${linein} | grep -o 'title="[^*]*:' | cut -d ":" -f1 | sed 's#Tags$##g' | tr " " "_" | cut -d '"' -f2 | sed 's#^[-_.]##g' | sed 's#amp##g' | tr -d ";" | sed 's#&#N#g' | sed 's#[()\"]##g' )$(basename ${PIC_LINK})
	echo "wget --user-agent=Mozilla ${PIC_LINK} -O ${DOWNLOAD_NAME} "
done 2>&1 > ${LIST2}

#cat ${LIST2} | sed 's#[()\`\"##g'

cat ${LIST2} | awk '!a[$0]++' >> .temp
mv .temp ${LIST2}



mv ${LIST2} ${PIC_DIR}/

cd ${PIC_DIR}/

ksh ${LIST2}


mv ${LIST2} ../${ARCHIVE_DIR} 

cd ..

mv ${LIST} ${LIST2} flickr_hvmnd* ${ARCHIVE_DIR} /


tar -cvf ${ARCHIVE_FILE} ${ARCHIVE_DIR}

bzip2 -9 -v ${ARCHIVE_FILE}

rm -rf ${ARCHIVE_DIR}





















