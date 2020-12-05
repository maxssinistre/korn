#!/bin/ksh


TODAY=$(date +%m%d%y%H%M%S)
TEMP_FILE=.temp
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
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.pornhub.com/video/search?search=${SEARCH}\&page=${count} -O ${PAGE}_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

cat $PAGE_* | grep -o 'href="[^*]*"' | grep view_video | grep class=\"title | cut -d '"'  -f2 >> ${TODAY_OUTPUT}


# download links 



#wget ${MYTH_WEBSITE} -O ${TODAY_OUTPUT}




	for T in $(cat ${TODAY_OUTPUT} ) ; do 
		echo "searching $T"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - |grep to.addVariable > ${TEMP_FILE}
		FILE=$(grep video_url ${TEMP_FILE} | cut -d '"' -f 4 | sed 's#%3Fr%3D100##g' | sed 's#%2F#/#g' | sed 's#%3A#:#g' | cut -d "%" -f1 )
		NAME=$(grep video_title ${TEMP_FILE} | cut -d '"' -f 4 )
		echo ${FILE}
		echo ${NAME}

	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
			while [ $( ps -ef | grep wget | wc -l ) -ge 2 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
		#read
	done


rm ${TODAY_OUTPUT} ${TEMP_FILE}





# http://192.168.1.100/mythweb/tv/recorded?sortby=airdate


        to.addVariable("autoplay","true");
        to.addVariable("autoreplay","false");
        to.addVariable("video_url","http%3A%2F%2Fnyc-v67.pornhub.com%2Fdl%2Fd1d96bdee5f2aca54759a34f113fc356%2F4d8b3e10%2Fvideos%2F001%2F050%2F370%2F1050370.flv%3Fr%3D100");
        to.addVariable("postroll_url","http%3A%2F%2Fcdn1.static.pornhub.phncdn.com%2Fflash%2Fpost_roll%2Faff_postroll%2Faff_v3.swf");
        to.addVariable("options","http%3A%2F%2Fwww.pornhub.com%2F");
        to.addVariable("related_url","http%3A%2F%2Fwww.pornhub.com%2Fvideo_related.php%3Fid%3D1050370");
        to.addVariable("link_url","http%3A%2F%2Fwww.pornhub.com%2Fview_video.php%3Fviewkey%3D918449471");
        to.addVariable("video_title","Crystal+Bottoms+Anal");
        to.addVariable("embed_js","embed_click()");
        to.addVariable("inplayer_url","http%3A%2F%2Fcdn1.static.pornhub.phncdn.com%2Fflash%2Finplayer.swf");


#<a class="x-pixmap" href="/mythweb/tv/detail/1055/1291420800" title="Recording Details"

#\<a\ class=\"x-pixmap\"\ href=\"/mythweb/tv/detail/${T}\"\ title=\"Recording\ Details\"


#http://xhamster.com/search.php?q=karla%20lane&page=1

#http://xhamster.com/search.php?q=karla+lane&page=2




