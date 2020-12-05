#!/bin/ksh


TODAY=$(date +%m%d%y%H%M%S)
TEMP_FILE_FANTASTICC=.temp_FANTASTICC
TODAY_OUTPUT_FANTASTICC=searched_FANTASTICC_${TODAY}
COUNT=$@
TEMP_FILE_JIZZ=.temp_jizz
TODAY_OUTPUT_JIZZ=searched_jizz_${TODAY}
TEMP_FILE_HAMSTER=.temp_hamster
TODAY_OUTPUT_HAMSTER=searched_hamster_${TODAY}
TEMP_FILE_REDTUBE=.temp_redtube
TODAY_OUTPUT_REDTUBE=searched_redtube_${TODAY}
TEMP_FILE_XVIDEO=.temp_xvideo
TODAY_OUTPUT_XVIDEO=searched_xvideo_${TODAY}
TEMP_FILE_PORNHUB=.temp_pornhub
TODAY_OUTPUT_PORNHUB=searched_pornhub_${TODAY}
TEMP_FILE_TUBE8=.temp_tube8
TODAY_OUTPUT_TUBE8=searched_tube8_${TODAY}
TEMP_FILE_SPANK=.temp_spank
TODAY_OUTPUT_SPANK=searched_spank_${TODAY}
TEMP_FILE_MOFO=.temp_mofo
TODAY_OUTPUT_MOFO=searched_mofo_${TODAY}
TEMP_FILE_SUNPORNO=.temp_sunporno
TODAY_OUTPUT_SUNPORNO=searched_sunporno_${TODAY}
TEMP_FILE_FOURTUBE=.temp_FOURTUBE
TODAY_OUTPUT_FOURTUBE=searched_FOURTUBE_${TODAY}
TEMP_FILE_TNAFLIX=.temp_TNAFLIX
TODAY_OUTPUT_TNAFLIX=searched_TNAFLIX_${TODAY}
TEMP_FILE_SEXBOT=.temp_SEXBOT
TODAY_OUTPUT_SEXBOT=searched_SEXBOT_${TODAY} 
TEMP_FILE_YAPTUBE=.temp_YAPTUBE
TODAY_OUTPUT_YAPTUBE=searched_YAPTUBE_${TODAY}

NO_CLOBBER=0

CONFIG=.temp
PAGE=webpage


#functions
function download_manager {

			while [ $( ps -ef | grep wget | wc -l ) -ge 3 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
}		

function check_names {   if [ $NO_CLOBBER -eq 1 ] ; then

		if [ -f ${NAME}.flv ] ; then
		
			NAME=${NAME}_${RANDOM}

		elif [ -f ${NAME}.mp4 ] ; then
		
			NAME=${NAME}_${RANDOM}

		fi

   elif [ $NO_CLOBBER -eq 0 ] ; then

		if [ -f ${NAME}.flv ] ; then
		
			echo " you already downloaded ${NAME} numbnuts......"
                        	echo " you already downloaded this"
                        	NAME=""
                        	FILE=""
                        	SERVER=""
                        	TEMP_FILE_JIZZ=""

		elif [ -f ${NAME}.mp4 ] ; then
		
			echo " you already downloaded ${NAME} numbnuts......"
                        	echo " you already downloaded this"
                        	NAME=""
                        	FILE=""
                        	SERVER=""
                        	TEMP_FILE_JIZZ=""

		fi
	
  fi

}

function yaptube {

# download links 

YAPTUBE_LINK=$1
NAME=$2  


	for YAPTUBE_LINK in $(cat ${TODAY_OUTPUT_YAPTUBE} ) ; do 
		echo "searching $YAPTUBE_LINK"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $YAPTUBE_LINK -O ${TEMP_FILE_YAPTUBE}
		FILE=$(cat ${TEMP_FILE_YAPTUBE} | grep player_url | grep http | cut -d "'" -f2 )
#		NAME=$(cat ${TEMP_FILE_YAPTUBE} | grep player_url | grep http | cut -d "'" -f2 | rev | cut -d "." -f2- | rev | awk -F "/" '{print $NF }')
		NAME=$(cat ${TEMP_FILE_YAPTUBE} | grep filename | cut -d '"' -f8 )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} &
		
		download_manager
	done


rm ${TODAY_OUTPUT_YAPTUBE} ${TEMP_FILE_YAPTUBE}*
}

function sexbot {

# download links 

SEXBOT_LINK=$1
NAME=$2  

		echo "searching $SEXBOT_LINK"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_SEXBOT}
		FILE=$(cat ${TEMP_FILE_SEXBOT} |grep file | cut -d "'" -f4 )
		NAME=$(cat ${TEMP_FILE_SEXBOT} | grep "<title>" | cut -d ">" -f2 |  cut -d "|" -f1 | sed 's#\ #+#g')
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager




}

function tnaflix {

# download links 

TNA_LINK=$1
NAME=$2  
		echo "searching $TNA_LINK"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $TNA_LINK -O ${TEMP_FILE_TNAFLIX}
		FILE_URL=$(cat ${TEMP_FILE_TNAFLIX} |grep tnaflv2 | grep -v height | cut -d '"' -f2 )
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE_URL} -O ${TEMP_FILE_TNAFLIX}_2
		FILE=$( cat ${TEMP_FILE_TNAFLIX}_2 | grep videoLink | cut -d ">" -f2 |  cut -d "<" -f1)
		#NAME=$(cat ${TEMP_FILE_TNAFLIX} | grep "<title>" | cut -d ">" -f2 |  cut -d "," -f1 | sed 's#\ #+#g' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	
rm ${TODAY_OUTPUT_TNAFLIX} ${TEMP_FILE_TNAFLIX}*

}

function fourtube {

FOUR=$1
NAME=$2  
		echo "searching $FOUR"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FOUR -O ${TEMP_FILE_FOURTUBE}
		FILE_URL=$(cat ${TEMP_FILE_FOURTUBE} | tr "<" "\n" | grep videoconfig | cut -d "'" -f4 | sed 's#config=##g' | sed 's#^#http://www.4tube.com#g')
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FILE_URL -O ${TEMP_FILE_FOURTUBE}_2
		FILE=$( cat ${TEMP_FILE_FOURTUBE}_2 | tr "<" "\n" | grep file | grep http | cut -d ">" -f 2 )
	#	NAME=$(cat ${TEMP_FILE_FOURTUBE} | grep "<title>" | cut -d ">" -f2 |  cut -d "|" -f1 | sed 's#\ #+#g' )
	#	NAME=$(echo $FOUR | awk -F "/" '{ print $NF }' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager



rm ${TODAY_OUTPUT_FOURTUBE} ${TEMP_FILE_FOURTUBE}*


}

function sunporno {

SUNNY=$1
NAME=$2  
		echo "searching $SUNNY"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $SUNNY -O ${TEMP_FILE_SUNPORNO}
		FILE=$(cat ${TEMP_FILE_SUNPORNO} | grep flv | cut -d "'" -f4 )
		#NAME=$(cat ${TEMP_FILE_SUNPORNO} | grep "<title>" | cut -d ">" -f2 |  cut -d "<" -f1 | sed 's#\ #+#g' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

rm ${TODAY_OUTPUT_SUNPORNO} ${TEMP_FILE_SUNPORNO}

}

function mofo {

# download links 

MOO=$1
NAME=$2  
		echo "searching $MOO"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $MOO -O ${TEMP_FILE_MOFO}
		FILE=$(cat ${TEMP_FILE_MOFO} | grep flashvars.video_url | cut -d "'" -f2 | awk '{ gsub ("%3A",":"); 
				gsub ("%2F","/");
				gsub ("%3F","?"); 
				gsub ("%3D","=");
				gsub ("%3B",";")
				gsub ("%26","\\&"); print }' )
		#NAME=$(cat ${TEMP_FILE_MOFO} | grep flashvars.video_title | cut -d "'" -f2 | sed 's#\ #+#g' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

rm ${TODAY_OUTPUT_MOFO} ${TEMP_FILE_MOFO}


}
function spankwire {
SPARK=$1
NAME=$2  

		echo "searching $SPARK"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $SPARK -O ${TEMP_FILE_SPANK}
		FILE=$(cat ${TEMP_FILE_SPANK} | grep flashvars.video_url | cut -d '"' -f2 | sed 's#%26#\&#g' )
		#NAME=$(cat ${TEMP_FILE_SPANK} | grep flashvars.video_title | cut -d '"' -f2 )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

rm ${TODAY_OUTPUT_SPANK} ${TEMP_FILE_SPANK}

}

function tube8 {

TUBEY=$1
NAME=$2  
		echo "searching $TUBEY"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $TUBEY -O ${TEMP_FILE_TUBE8}
		FILE=$(cat ${TEMP_FILE_TUBE8} | grep videourl | grep flv | cut -d '"' -f2 )
		#NAME=$(cat ${TEMP_FILE_TUBE8} | grep flashvars.video_title | cut -d '"' -f2 )
		#NAME=$(cat ${TEMP_FILE_TUBE8} | grep "main-title main-sprite-img" | head -1 | cut -d ">" -f2 | sed 's#</h1##g' | sed 's#\ #_#g')
		echo ${FILE}
		echo ${NAME}
		check_names 
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

rm ${TODAY_OUTPUT} ${TEMP_FILE}


}	

function pornhub {

HUBBY=$1
NAME=$2  
		echo "searching $HUBBY"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $HUBBY -O - |grep to.addVariable > ${TEMP_FILE_PORNHUB}
		FILE=$(grep video_url ${TEMP_FILE_PORNHUB} | cut -d '"' -f 4 | sed 's#%3Fr%3D100##g' | sed 's#%2F#/#g' | sed 's#%3A#:#g' | cut -d "%" -f1 )
		#NAME=$(grep video_title ${TEMP_FILE_PORNHUB} | cut -d '"' -f 4 )
		echo ${FILE}
		echo ${NAME}
		check_names	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		download_manager


rm ${TODAY_OUTPUT} ${TEMP_FILE}
}

function xvideos {

XVI=$1
NAME=$2  
		echo "searching $XVI"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $XVI -O - | tr ";" "\n" | grep flv_url  > ${TEMP_FILE_XVIDEO}
		FILE=$(cat ${TEMP_FILE_XVIDEO} | cut -d "=" -f2 | sed 's#%3Fr%3D100##g' | sed 's#%2F#/#g' | sed 's#%3A#:#g' | sed 's#%3F#?#g' | sed 's#%3D#=#g'| sed 's#%26#\&#g' )
		#NAME=$(echo $XVI | awk -F "/" '{ print $NF }')
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

rm ${TODAY_OUTPUT_XVIDEO} ${TEMP_FILE_XVIDEO}

} 
 
function redtube {

RED=$1
NAME=$2  
		echo "searching $RED"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $RED -O ${TEMP_FILE_REDTUBE}
		FILE=$(cat ${TEMP_FILE_REDTUBE} | grep -o 'src="[^*]*"' | grep mp4 | cut -d '"' -f2 )
		#NAME=$(cat ${TEMP_FILE_REDTUBE} | grep videoTitle | cut -d ">" -f2 | cut -d "<" -f1 | tr " " "_")
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.mp4 &
		
		download_manager

rm ${TODAY_OUTPUT_REDTUBE} ${TEMP_FILE_REDTUBE}

}

function youjizz {

JIZZ=$1
NAME=$2  
		echo "searching $JIZZ"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $JIZZ -O - | grep 'so.addVariable("file"' | cut -d '"' -f4 > ${TEMP_FILE_JIZZ}
		#NAMEN_JIZZ=$(echo $JIZZ | sed 's#.html$##g' | awk -F "/" ' { print $NF}')
		check_names
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i ${TEMP_FILE_JIZZ} -O ${NAME}.flv & 
		download_manager		


rm ${TODAY_OUTPUT_JIZZ} ${TEMP_FILE_JIZZ}

}

function xhamster {

HAMS=$1
NAME=$2  
		echo "searching $HAMS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $HAMS -O - |grep -A 4 flashvars > ${TEMP_FILE_HAMSTER}
		SERVER=$(grep srv ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		FILE=$(grep file ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		IMAGE=$(grep image ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${IMAGE} 		
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${SERVER}/flv2/${FILE} &
		download_manager

rm ${TODAY_OUTPUT_HAMSTER} ${TEMP_FILE_HAMSTER}


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
      	
		while [ ${count} -ge 0 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://fantasti.cc/search/${SEARCH}/videos/page_${count} -O ${PAGE}_FANTASTICC_${count}	
		let count=$count-1
			
		done

#pull links out of downloaded file

cat webpage_FANTASTICC_* |  grep -o 'href="[^*]*"' | awk -F '"' '/permalink/ { print "http://fantasti.cc"$2 }' >> ${TODAY_OUTPUT_FANTASTICC}


# download links 



	for FANTAS_LINKS in $(cat ${TODAY_OUTPUT_FANTASTICC} ) ; do 
		echo "searching ${FANTAS_LINKS}"  

		NAME=$(echo ${FANTAS_LINKS} | rev | cut -d "/" -f3- | rev | awk -F "/" '{ print $NF }')
		
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FANTAS_LINKS} -O ${TEMP_FILE_FANTASTICC}

		LINKY=$(cat ${TEMP_FILE_FANTASTICC} | grep BBB | cut -d '"' -f4 )

		if [ $(echo ${FANTAS_LINKS} | grep -i redtube | wc -l ) -eq 1 ] ; then

		redtube ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i youjizz | wc -l ) -eq 1 ] ; then
	
		youjizz ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i xvideo | wc -l ) -eq 1 ] ; then
	
		xvideos ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i pornhub | wc -l ) -eq 1 ] ; then
	
		pornhub ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i xhamster | wc -l ) -eq 1 ] ; then
	
		xhamster ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i tube8 | wc -l ) -eq 1 ] ; then
	
		tube8 ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i spankwire | wc -l ) -eq 1 ] ; then
	
		spankwire ${LINKY} ${NAME}
	
		elif [ $(echo ${FANTAS_LINKS} | grep -i mofosex | wc -l ) -eq 1 ] ; then
	
		mofo ${LINKY} ${NAME}
	
		elif [ $(echo ${FANTAS_LINKS} | grep -i sunporno | wc -l ) -eq 1 ] ; then
	
		sunporno ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i 4tube | wc -l ) -eq 1 ] ; then
	
		fourtube ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i tnaflix | wc -l ) -eq 1 ] ; then

		tnaflix ${LINKY} ${NAME}

		elif [ $(echo ${FANTAS_LINKS} | grep -i sexbot | wc -l ) -eq 1 ] ; then

		sexbot ${LINKY} ${NAME}

		fi

		
		download_manager
	done


rm ${TODAY_OUTPUT_FANTASTICC} ${TEMP_FILE_FANTASTICC}*




