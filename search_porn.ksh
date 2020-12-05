#!/bin/ksh

#needed variable
TODAY=$(date +%m%d%y%H%M%S)
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
TEMP_FILE_JOGGS=.temp_JOGGS
TODAY_OUTPUT_JOGGS=searched_JOGGS_${TODAY}
TEMP_FILE_TITWORLD=.temp_TITWORLD
TODAY_OUTPUT_TITWORLD=searched_TITWORLD_${TODAY}
TEMP_FILE_MACHINIMA=.temp_MACHINIMA
TODAY_OUTPUT_MACHINIMA=searched_MACHINIMA_${TODAY}
TEMP_FILE_ZBPOO=.temp_ZBPOO
TODAY_OUTPUT_ZBPOO=searched_ZBPOO_${TODAY}
TEMP_FILE_XANIME=.temp_XANIME
TODAY_OUTPUT_XANIME=searched_XANIME_${TODAY}
TEMP_FILE_HQBUTT=.temp_HQBUTT
TODAY_OUTPUT_HQBUTT=searched_HQBUTT_${TODAY}
TEMP_FILE_TUBECLASSIC=.temp_TUBECLASSIC
TODAY_OUTPUT_TUBECLASSIC=searched_TUBECLASSIC_${TODAY}
TEMP_FILE_XXXCLASSIC=.temp_XXXCLASSIC
TODAY_OUTPUT_XXXCLASSIC=searched_XXXCLASSIC_${TODAY}
TEMP_FILE_SPANKBANG=.temp_spankbang
TODAY_OUTPUT_SPANKBANG=searched_spankbang_${TODAY}
TEMP_FILE_XNXX=.temp_xnxx
TODAY_OUTPUT_XNXX=searched_xnxx_${TODAY}
TEMP_FILE_HENTAIGASM=.temp_hentaigasm
TODAY_OUTPUT_HENTAIGASM=searched_hentaigasm_${TODAY}
TEMP_FILE_HENTAIHAVEN=.temp_hentaigasm
TODAY_OUTPUT_HENTAIHAVEN=searched_hentaigasm_${TODAY}
TEMP_FILE_SHESFREAKY=.temp_shesfreaky
TODAY_OUTPUT_SHESFREAKY=searched_shesfreaky_${TODAY}
TEMP_FILE_LIEB=.temp_lieb
TODAY_OUTPUT_LIEB=searched_lieb_${TODAY}
TEMP_FILE_HEAVYR=.temp_heavyr
TODAY_OUTPUT_HEAVYR=searched_heavyr_${TODAY}
TEMP_FILE_YOURP=.temp_yourp
TODAY_OUTPUT_YOURP=searched_yourp_${TODAY}
TEMP_FILE_BESTP=.temp_bestp
TODAY_OUTPUT_BESTP=searched_bestp_${TODAY}
TEMP_FILE_BIGUZ=.temp_BIGUZ
TODAY_OUTPUT_BIGUZ=searched_biguz_${TODAY}
TEMP_FILE_FETISH=.temp_FETISH
TODAY_OUTPUT_FETISH=searched_FETISH_${TODAY}
TEMP_FILE_EXTREMETUBE=.temp_EXTREMETUBE
TODAY_OUTPUT_EXTREMETUBE=searched_EXTREMETUBE_${TODAY}

TODAY_OUTPUT_STRAPATUER=searched_STRAPATUER_${TODAY}
TEMP_FILE_STRAPATUER=.temp_STRAPATUER
TODAY_OUTPUT_STRAPATUER=searched_STRAPATUER_${TODAY}

#COUNT_JIZZ=$1
#COUNT_HAMSTER=$2

REDTUBE=0
YOUJIZZ=0
XVIDEO=0
PORNHUB=0
XHAMSTER=0
TUBE8=0
SPANKWIRE=0
MOFO=0
SUNPORNO=0
FOURTUBE=0
JOGGS=0
TITWORLD=0
NO_CLOBBER=0
JOGG_PORNSTAR=0
MACHINIMA=0
XANIME=0
HQBUTT=0
TUBECLASSIC=0
XXXCLASSIC=0
SPANKBANG=0
XNXX=0
LIEB=0
HEAVYR=0
YOURP=0
BESTP=0
BIGUZ=0
FETISH=0
EXTREMETUBE=0
STRAPATUER=0

CONFIG=.temp
PAGE=webpage

#function
function usage {

echo "
	app for downloading vids from various porn sites
	-C to choose tubepornclassic
	-w to choose titworld
	-q to choose hqbutt - all butts , all the time
	-r to choose redtube
	-j to choose youjizz 
	-x to choose xvideos
	-X to choose xxxanimemovies
	-p to choose pornhub
	-h to choose xhamster
	-t to choose tube8
	-S to choose spankwire
        -B to choose spankbang
	-m to choose mofo
	-M to choose naughtymachinima (cg fucking )
	-u to choose sunporno
	-4 to choose fourtube
	-T to choose Tnaflix
	-b to choose sexbot
	-z to choose zbporn
	-y to choose yaptube
	-f to choose shesfreaky
	-l to choose lieb
	-Y to choose heavy-r
	-U to choose yourporn
	-G to choose bestpeg
	-Q to choose strapatuer
	-I to choose biguz
	-H to choos hentaigasm (new)
	-E to choose hentaihaven (new)
	-N to choose xnxx
	-F to choose fetish.sexy
	-e to choose extremetube
	-J to choose joggs big boob site  use -P command to pull up pornstar page on site since joggs search sucks
	   note: make sure you spell the name right, this is very picky....
	-a do them all
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-c page count to download
	-R how many paralell downloads at once
	-s put what you want to search for here. If nothing entered the script will ask you.
	   *note enclose searches with spaces in quotes	

T and y work	
REDTUBE,xhamster works now 11/18/12
xvideos, youjizz 12/8/12
added zbporn 060315- peep the slick awk
configured working ones under -a will add others as i fix them
"
exit 0
}

function youtube_command {

youtube-dl --sleep-interval 1 --max-sleep-interval 30 -v -t -i $@

}

function download_manager {

#NERD=$@

#			while [ $( ps -ef | grep w[g]et | wc -l ) -ge 3 ] ;do
#			while [ $( ps -ef | grep w[g]et | wc -l ) -ge ${RATE} ] ;do
			while [ $( ps -ef | awk '/w[g]et|youtu[b]e-dl/ { print $0 }' | wc -l ) -ge ${RATE} ] ;do
				echo "waiting for download slots"
				sleep 30
			done
}	

function check_names {

#CLOBBER=$@

   if [ -z ${NAME} ] ; then
	NAME=${RANDOM}_bustedname
   fi

   if [ $NO_CLOBBER -eq 1 ] ; then

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

function check_names_old {

#CLOBBER=$@

   if [ $NO_CLOBBER -eq 1 ] ; then

		if [ $( ls *.flv | grep ${NAME}.flv | wc -l ) -ge 1 ] ; then
		
			NAME=${NAME}_${RANDOM}

		elif [ $( ls *.mp4 | grep ${NAME}.mp4 | wc -l ) -ge 1 ] ; then
		
			NAME=${NAME}_${RANDOM}

		fi
   elif [ $NO_CLOBBER -eq 0 ] ; then

		if [ $( ls *.flv | grep ${NAME}.flv | wc -l ) -ge 1 ] ; then
		
			echo " you already downloaded ${NAME} numbnuts......"

		elif [ $( ls *.mp4 | grep ${NAME}.mp4 | wc -l ) -ge 1 ] ; then
		
			echo " you already downloaded ${NAME} numbnuts......"

		fi
	
  fi
}

#=====================================================================================================================================
function strapatuer {

        # clean up search syntax and long filename


        SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

        # download all search pages

        #count=${COUNT:-2}
        count=0

                        while [ ${count} -ge 0 ]
                        do
                                wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" "https://strapateur.com/page/${count}/?s=${SEARCH}" -O webpage_STRAPATUER_${count}

                let count=$count-1


                        done

        #pull links out of downloaded file

#cat webpage_STRAPATUER_* | awk -F '"' '/video/ && /href=/ && /id=\"/ && !/keyword|\/videos\?search|videoDuration/ {print "http:"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_STRAPATUER}
cat webpage_STRAPATUER_* | awk -F '"' '!/application\/rss\+xml|application\/rsd\+xml|wordpress/ && /title=/ && /https\:\/\/strapateur.com\// { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_STRAPATUER}

# download links



        for FASS in $(cat ${TODAY_OUTPUT_STRAPATUER} ) ; do
                echo "searching $FASS"

                youtube_command -i ${FASS} &

                download_manager
        done


#rm ${TODAY_OUTPUT_EXTREMETUBE} ${TEMP_FILE_EXTREMETUBE}*
rm ${TEMP_FILE_STRAPATUER}*

}

#=====================================================================================================================================
function extremetube {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	#count=${COUNT:-2}
	count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" "https://www.extremetube.com/videos?search=${SEARCH}#${count}" -O webpage_EXTREMETUBE_${count}

		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_EXTREMETUBE_* | awk -F '"' '/video/ && /href=/ && /id=\"/ && !/keyword|\/videos\?search|videoDuration/ {print "http:"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_EXTREMETUBE}

# download links 



	for FASS in $(cat ${TODAY_OUTPUT_EXTREMETUBE} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_EXTREMETUBE} ${TEMP_FILE_EXTREMETUBE}*
rm ${TEMP_FILE_EXTREMETUBE}*

}
#=====================================================================================================================================
function fetish {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	#count=${COUNT:-2}
	count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" "http://fetishtube.sexy/search/?q=${SEARCH}&rsnm=${count}" -O webpage_FETISH_${count}

		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_FETISH_* | awk -F '"' '/videos\// { print "http://fetishtube.sexy"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_FETISH}



# download links 



	for FASS in $(cat ${TODAY_OUTPUT_FETISH} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_FETISH} ${TEMP_FILE_FETISH}*
rm ${TEMP_FILE_FETISH}*

}
#=====================================================================================================================================
function biguz {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	#count=${COUNT:-2}
	count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://biguz.net/search.php?q=${SEARCH} -O webpage_BIGUZ_${count}

		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_BIGUZ_* | tr '"' "\n" | awk '/\/watch.php/ { print "https://biguz.net"$0 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_BIGUZ}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_BIGUZ} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_BIGUZ} ${TEMP_FILE_BIGUZ}*
rm ${TEMP_FILE_BIGUZ}*

}
#=====================================================================================================================================
function bestpeg {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://bestpegging.com/page/${count}/?s=${SEARCH} -O webpage_BESTP_${count}

		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_BESTP_* | tr " " "\n" | awk -F '"' '/href=\"https:\/\/bestpegging.com\// && !/\/categor|\/\?filter|\/tags\/|bestpegging.com\/\"|\/feed|\/wp-content|\/search|\/xmlrpc|\/wp-includes|\/contact-us|\/page\// { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_BESTP}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_BESTP} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_BESTP} ${TEMP_FILE_BESTP}*
rm  ${TEMP_FILE_BESTP}*

}
#=====================================================================================================================================
function yourporn {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #-#g')

	# download all search pages

	count_temp=${COUNT:-2}
	let count=$count_temp*30
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://yourporn.sexy/${SEARCH}.html?page=${count} -O webpage_YOURP_${count}

		let count=$count-30
	
				
			done

	#pull links out of downloaded file

#cat webpage_YOURP_* | tr "'" "\n" | awk '/\/post/ && /.html/ { print "https://yourporn.sexy"$0 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_YOURP}

cat webpage_YOURP_* | tr "'" "\n" | awk -F "?" '/\/post/ && /.html/ { print "https://yourporn.sexy"$1 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_YOURP}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_YOURP} ) ; do 
		echo "searching $FASS"  
			
		#youtube_command -i ${FASS} &

		echo "searching $FASS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_YOURP}
#		GETIT=$(cat ${TEMP_FILE_YOURP}_dodo | tr "?" "\n" | awk -F '"' '/vkey=/ { print "http://www.naughtymachinima.com/media/player/config_embed.php?"$1;exit; }')
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $GETIT -O ${TEMP_FILE_YOURP}
		FILE=$(cat ${TEMP_FILE_YOURP} | tr " " "\n" |  awk -F '"' '/cdn/ && /data-vnfo=/ { gsub("\\\\/","/") ; print "https://yourporn.sexy"$4 }')

#		if [ $( echo $FILE | wc ) -lt 10 ] ; then
#		if [ -z $FILE  ] ; then

#		FILE=$(cat ${TEMP_FILE_YOURP} | awk '/src/ && /flv/ && /video/ && /naughtymachinima/ { gsub ("<src>","") ; gsub ("</src>","") ; gsub ("\ ","") ; print $0 }' )

#		fi

		NAME=$(cat ${TEMP_FILE_YOURP} | awk -F '>|<' '/<title>/ { gsub("on YourPorn. Sexy","") ; gsub(" ","_") ; print $3".mp4" }')

		echo ${FILE}
		echo ${NAME} 
		check_names
		echo ${NAME}
	read
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.mp4 &
#		youtube-dl -v ${FILE} -o ${NAME}.mp4 &
		youtube_command ${FILE} &

		
		
		download_manager
	done


#rm ${TODAY_OUTPUT_YOURP} ${TEMP_FILE_YOURP}*
rm  ${TEMP_FILE_YOURP}*

}

#=====================================================================================================================================
function heavyr {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #-#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://www.heavy-r.com/search/${SEARCH}_${count}.html } -O webpage_HEAVYR_${count}


		let count=$count-1
	
				
			done

	#pull links out of downloaded file

#cat webpage_HEAVYR_* | tr '"' "/n" | tr " " "\n" |  awk -F ">" '/href=\/\/video/ { gsub("//","/") ; gsub("href=/","http://www.heavy-r.com/"); print $1 }' >> ${TODAY_OUTPUT_HEAVYR}

cat webpage_HEAVYR_* | tr '"' "/n" | tr " " "\n" |  awk '/href=\/\/video/ && !/>/ { gsub("//","/") ; gsub("href=/","http://www.heavy-r.com/"); print $0 }' >> ${TODAY_OUTPUT_HEAVYR}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_HEAVYR} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_HEAVYR} ${TEMP_FILE_HEAVYR}*
rm ${TEMP_FILE_HEAVYR}*

}
#=====================================================================================================================================

function lieb {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #-#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://www.liebelib.net/${SEARCH}.html\?page=${count} -O webpage_LIEB_${count}


		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_LIEB_* | awk -F '"' '/href\=\"\/movie\// { print "https://liebelib.net"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_LIEB}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_LIEB} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_LIEB} ${TEMP_FILE_LIEB}*
rm  ${TEMP_FILE_LIEB}*

}




#=====================================================================================================================================

function shesfreaky {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #-#g')

	# download all search pagesyour

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
				wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://www.shesfreaky.com/search/videos/${SEARCH}/page${count}.html -O webpage_SHESFREAKY_${count}

		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_SHESFREAKY_* | tr '"' "\n" | awk '/video/ && /html/ && /com/ { print $0 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_SHESFREAKY}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_SHESFREAKY} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_SHESFREAKY} ${TEMP_FILE_SHESFREAKY}*
rm ${TEMP_FILE_SHESFREAKY}*

}



#=====================================================================================================================================

function hentaihaven {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://hentaihaven.org/search/${SEARCH} -O webpage_HENTAIHAVEN_${count}
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://hentaihaven.org/search/${SEARCH}#top -O webpage_HENTAIHAVEN_top_${count}

#http://www.hentaihaven.com/?k=${SEARCH}\&p=${count} -O webpage_HENTAIHAVEN_${count}
		
		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_HENTAIHAVEN_* | awk -F '"' '/hentaihaven.org/ && /brick-title/ { print $4 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HENTAIHAVEN}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_HENTAIHAVEN} ) ; do 
		echo "searching $FASS"
		
		VIDEO_URL=$(wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O - | awk -F "'" '/mp4/ && /var new_url = data.length/ { print $2 }' | awk '!a[$0]++' )
		VIDEO_NAME=$( youtube-dl -e $FASS | detox --inline ).mp4
		VIDEO_ORIG=$(echo ${VIDEO_URL} | awk -F "/" '{ print $NF }')
			
		youtube_command -i ${VIDEO_URL} &
		
		mv -v ${VIDEO_ORIG} ${VIDEO_NAME}
		
		download_manager
	done


#rm ${TODAY_OUTPUT_HENTAIHAVEN} ${TEMP_FILE_HENTAIHAVEN}*
rm ${TEMP_FILE_HENTAIHAVEN}*

}

#=====================================================================================================================================

function hentaigasm {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://hentaigasm.com/page/${count}/?s=${SEARCH} -O webpage_HENTAIGASM_${count}

#http://www.hentaigasm.com/?k=${SEARCH}\&p=${count} -O webpage_HENTAIGASM_${count}
		
		let count=$count-1
	
				
			done

	#pull links out of downloaded file

cat webpage_HENTAIGASM_* | awk -F '"' '/clip-link/ { print $8 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HENTAIGASM}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_HENTAIGASM} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_HENTAIGASM} ${TEMP_FILE_HENTAIGASM}*
rm ${TEMP_FILE_HENTAIGASM}*

}
#=====================================================================================================================================

function xnxx {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
	#count=0
      	
			while [ ${count} -ge 0 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.xnxx.com/search/${SEARCH}/${count}/ -O webpage_XNXX_${count}

#http://www.xnxx.com/?k=${SEARCH}\&p=${count} -O webpage_XNXX_${count}
		
		let count=$count-1
	
				
			done

	#pull links out of downloaded file

#cat webpage_XNXX_* | awk -F '"' '/video/ && /href/ && !/\?order|stylesheet|fa fa|li class|^http/ { print "http://xnxx.com"$10 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_XNXX}_1
#cat webpage_XNXX_* | awk -F '"' '/video/ && /href/ && !/\?order|stylesheet|fa fa|li class|^http/ { print "http://xnxx.com"$24 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_XNXX}_1
#cat ${TODAY_OUTPUT_XNXX}_1 | grep video | awk '!a[$0]++' > ${TODAY_OUTPUT_XNXX}
#rm ${TODAY_OUTPUT_XNXX}_1

cat webpage_XNXX_* | tr '"' "\n" | awk '/\/video-/ { gsub("/THUMBNUM","") ; print "https://www.xnxx.com"$0 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_XNXX}

# download links 



	for FASS in $(cat ${TODAY_OUTPUT_XNXX} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_XNXX} ${TEMP_FILE_XNXX}*
rm ${TEMP_FILE_XNXX}*

}

##########################################################################################################################################################################################

function spankbang {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

	# download all search pages

	count=${COUNT:-2}
	#count=1
      	
			while [ ${count} -ge 1 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://spankbang.com/s/${SEARCH}/${count}/ -O webpage_SPANKBANG_${count}
		
		let count=$count-1
	
				
			done

	#pull links out of downloaded file

#cat webpage_SPANKBANG_* | awk -F '"' '/com\/videos\// { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_SPANKBANG}
cat webpage_SPANKBANG_* | awk -F '"' '/video/ && /href/ && !/\?order|stylesheet|fa fa|li class/ { print "http://spankbang.com"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_SPANKBANG}

# download links 



	for FASS in $(cat ${TODAY_OUTPUT_SPANKBANG} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_SPANKBANG} ${TEMP_FILE_SPANKBANG}*
rm ${TEMP_FILE_SPANKBANG}*

}


##########################################################################################################################################################################################

function tubeclassic {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

	# download all search pages

	count=${COUNT:-2}
	#count=1
      	
			while [ ${count} -ge 1 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.tubepornclassic.com/search/${SEARCH}/${count}/ -O webpage_TUBECLASSIC_${count}
		
		let count=$count-1

		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.tubeclassic.com/en/search/${SEARCH}/${count}/ -O webpage_TUBECLASSIC_${count}

			
				
			done

	#pull links out of downloaded file

cat webpage_TUBECLASSIC_* | awk -F '"' '/com\/videos\// { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_TUBECLASSIC}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_TUBECLASSIC} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_TUBECLASSIC} ${TEMP_FILE_TUBECLASSIC}*
rm ${TEMP_FILE_TUBECLASSIC}*

}


##########################################################################################################################################################################################

function hqbutt {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

	# download all search pages

	count=${COUNT:-2}
	#count=1
      	
			while [ ${count} -ge 1 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.hqbutt.com/en/search/${SEARCH}/${count}/ -O webpage_HQBUTT_${count}
		
		let count=$count-1

		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.hqbutt.com/en/search/${SEARCH}/${count}/ -O webpage_HQBUTT_${count}

			
				
			done

	#pull links out of downloaded file

cat webpage_HQBUTT_* | tr '"' "\n" | awk '/go\?v=/ { print "http://www.hqbutt.com"$0 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HQBUTT}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_HQBUTT} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_HQBUTT} ${TEMP_FILE_HQBUTT}*
rm ${TEMP_FILE_HQBUTT}*

}


##########################################################################################################################################################################################

function xanime {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
	#count=1
      	
			while [ ${count} -ge 1 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.xxxanimemovies.com/search/hottest/${SEARCH}-${count}.html -O webpage_XANIME_${count}
		
		let count=$count-1

		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.xxxanimemovies.com/search/newest/${SEARCH}-${count}.html -O webpage_XANIME_${count}

			
				
			done

	#pull links out of downloaded file

cat webpage_XANIME_* | grep -B5 SThDuration | awk -F '"' '/\/play/ { print "http://www.xxxanimemovies.com"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_XANIME}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_XANIME} ) ; do 
		echo "searching $FASS"  
			
		youtube_command -i ${FASS} &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_XANIME} ${TEMP_FILE_XANIME}*
rm ${TEMP_FILE_XANIME}*

}

##########################################################################################################################################################################################


function zbpoo {

	# clean up search syntax and long filename
	

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
      	
			while [ ${count} -ge 1 ]
			do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://zbporn.com/search/${count}/?q=${SEARCH}?start=${count} -O webpage_ZBPOO_${count}

			let count=$count-1
				
			done

	#pull links out of downloaded file

#cat webpage_ZBPOO_* | awk '/rotator_params/ { gsub ("\ ","\n") ; print $0 }' | awk -F '\"' '/href/ && /zbporn.com/ { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_ZBPOO}
cat webpage_ZBPOO_* | awk -F '"' '/href/ && /title/ && /zbporn.com/ { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_ZBPOO}



# download links 



	for FASS in $(cat ${TODAY_OUTPUT_ZBPOO} ) ; do 
		echo "searching $FASS"  
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_ZBPOO}
#		FILE=$(cat ${TEMP_FILE_ZBPOO} | awk -F "\'" '/mp4/ && /get_file/ && /flashvars/ { gsub (",","\n") ; print $4 }' )
#		NAME=$(cat ${TEMP_FILE_ZBPOO} | grep title | awk -F ">|<" '{ gsub (" ","_") ; gsub ("_/_ZB_Porn","") ; print $3 }' | head -1)
#		echo ${FILE}
#		echo ${NAME} 
#		check_names
#		echo ${NAME}

		youtube_command $FASS	
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_ZBPOO} ${TEMP_FILE_ZBPOO}*
rm ${TEMP_FILE_ZBPOO}*

}

##########################################################################################################################################################################################

function machinima {

#machinima
#MACHINIMA

	# clean up search syntax and long filename

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
      	
			while [ ${count} -ge 1 ]
			do
#			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.naughtymachinima.com/search?search_query=${SEARCH}\&search_type=videos\&page=${count} -O webpage_MACHINIMA_${count}
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://www.naughtymachinima.com/search/videos?search_query=${SEARCH}\&page=${count} -O webpage_MACHINIMA_${count}
			let count=$count-1
				
			done

	#pull links out of downloaded file

#	cat webpage_MACHINIMA_* | awk -F '"' '/video/ && /media/ && /title/ { print "http://www.naughtymachinima.com"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_MACHINIMA}
#	cat webpage_MACHINIMA_* | awk -F '"' '/video\// && /href=/ && !/search_query/ { print "https://www.naughtymachinima.com"$2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_MACHINIMA}
	cat webpage_MACHINIMA_* | awk -F '"' '/title/ && /duration/ { print "https://www.naughtymachinima.com"$12 }'  | awk '!a[$0]++' >> ${TODAY_OUTPUT_MACHINIMA}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_MACHINIMA} ) ; do 
		echo "searching $FASS"  
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_MACHINIMA}_dodo
#		GETIT=$(cat ${TEMP_FILE_MACHINIMA}_dodo | tr "?" "\n" | awk -F '"' '/vkey=/ { print "http://www.naughtymachinima.com/media/player/config_embed.php?"$1;exit; }')
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $GETIT -O ${TEMP_FILE_MACHINIMA}
#		FILE=$(cat ${TEMP_FILE_MACHINIMA} | awk '/hd/ && /mp4/ && /video/ && /naughtymachinima/ { gsub ("<hd>","") ; gsub ("</hd>","") ; gsub ("\ ","") ; print $0 }' )
		
#		if [ $( echo $FILE | wc ) -lt 10 ] ; then
#		if [ -z $FILE  ] ; then

#		FILE=$(cat ${TEMP_FILE_MACHINIMA} | awk '/src/ && /flv/ && /video/ && /naughtymachinima/ { gsub ("<src>","") ; gsub ("</src>","") ; gsub ("\ ","") ; print $0 }' )

#		fi

#		NAME=$(cat ${TEMP_FILE_MACHINIMA} | awk -F "/" '/share/ && /video/ && /naughtymachinima/ { gsub ("<share>","") ; gsub ("</share>","") ; gsub ("\ ","") ; print $NF }')
#		echo ${FILE}
#		echo ${NAME} 
#		check_names
#		echo ${NAME}
	
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.mp4 &
		youtube_command $FASS &		
		download_manager
	done


#rm ${TODAY_OUTPUT_MACHINIMA} ${TEMP_FILE_MACHINIMA}*
rm ${TEMP_FILE_MACHINIMA}*

}

##########################################################################################################################################################################################

function titworld {

	# clean up search syntax and long filename

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

	# download all search pages

	count=${COUNT:-2}
      	
			while [ ${count} -ge 1 ]
			do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.titworld.net/?search=${SEARCH}\&cstart=${count} -O webpage_TITWORLD_${count}
			let count=$count-1
				
			done

	#pull links out of downloaded file

	cat webpage_TITWORLD_* | grep -o 'href="[^*]*"' | grep title | awk -F '"' '/titworld/ { print $2 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_TITWORLD}



# download links 



	for FASS in $(cat ${TODAY_OUTPUT_TITWORLD} ) ; do 
		echo "searching $FASS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_TITWORLD}
		FILE=$(cat ${TEMP_FILE_TITWORLD} | awk -F "'" '/file/ { print $4 }' | head -1 )
#		NAME=$(cat ${TEMP_FILE_TITWORLD} | grep player_url | grep http | cut -d "'" -f2 | rev | cut -d "." -f2- | rev | awk -F "/" '{print $NF }')
		NAME=$(cat ${TEMP_FILE_TITWORLD} | grep title | cut -d ">" -f2 | cut -d "<" -f1 | tr "\ " "_" | head -1)
		echo ${FILE}
		echo ${NAME} 
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_TITWORLD} ${TEMP_FILE_TITWORLD}*
rm ${TEMP_FILE_TITWORLD}*

}

##########################################################################################################################################################################################

function joggs {


if [ ${JOGG_PORNSTAR} -eq 0 ] ; then

	# clean up search syntax and long filename

	SEARCH=$(echo ${SEARCH1} | sed 's#\ #%20#g')

	# download all search pages

	count=${COUNT:-2}
      	
			while [ ${count} -ge 1 ]
			do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://joggs.com/search/${SEARCH}/page${count}.html${count}.html -O webpage_JOGGS_${count}
			let count=$count-1
				
			done

	#pull links out of downloaded file

	cat webpage_JOGGS_* | grep -o 'href="[^*]*"' | awk -F '"' '/videos/ { print $2 }' | grep -v \& | grep html | awk '!a[$0]++' >> ${TODAY_OUTPUT_JOGGS}

else
 	echo "make sure you spell the name right, this is very picky...."
	SEARCH=$(echo ${JOGG_PORNSTAR} | sed 's#\ #-#g')
	FIRST_LETTER=$(echo ${JOGG_PORNSTAR} | cut -c1 | tr [:lower:] [:upper:] )

	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://joggs.com/pornstars/${FIRST_LETTER}/ -O webpage_${FIRST_LETTER}

	PORNSTAR_PAGE=$(cat webpage_${FIRST_LETTER} | grep ${SEARCH} | head -1 | cut -d '"' -f 2)
	
	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${PORNSTAR_PAGE} -O webpage_JOGGS_${count}
	
	cat webpage_JOGGS_* | grep -o 'href="[^*]*"' | awk -F '"' '/videos/ { print $2 }' | grep -v \& | grep html | awk '!a[$0]++' >> ${TODAY_OUTPUT_JOGGS}


fi


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_JOGGS} ) ; do 
		echo "searching $FASS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_JOGGS}
		FILE=$(cat ${TEMP_FILE_JOGGS} | grep flashvars | head -1 | awk -F "=" '/videos/{ print $4 }' | cut -d "&" -f1 | sed 's#\ #%20#g' | awk '!a[$0]++' )
#		NAME=$(cat ${TEMP_FILE_JOGGS} | grep player_url | grep http | cut -d "'" -f2 | rev | cut -d "." -f2- | rev | awk -F "/" '{print $NF }')
		NAME=$(cat ${TEMP_FILE_JOGGS} | grep title | cut -d ">" -f2 | cut -d "<" -f1 | tr "\ " "_" )
		echo ${FILE}
		echo ${NAME} 
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_JOGGS} ${TEMP_FILE_JOGGS}*
rm ${TEMP_FILE_JOGGS}*
}

##########################################################################################################################################################################################

function yaptube {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.yaptube.com/search/straight/${SEARCH}/WANKS/ne/70831/page${count} -O ${PAGE}_YAPTUBE_${count}
		let count=$count-1
			
		done

#pull links out of downloaded file

cat webpage_YAPTUBE_* |grep -o 'href="[^*]*"' | awk -F '"' '/watch/{ print "http://www.yaptube.com"$2 }' | awk '!a[$0]++'   >> ${TODAY_OUTPUT_YAPTUBE}


# download links 



	for FASS in $(cat ${TODAY_OUTPUT_YAPTUBE} ) ; do 
		echo "searching $FASS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_YAPTUBE}
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


#rm ${TODAY_OUTPUT_YAPTUBE} ${TEMP_FILE_YAPTUBE}*
rm  ${TEMP_FILE_YAPTUBE}*
}

##########################################################################################################################################################################################

function sexbot {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.SEXBOT.com/search.php?page=${count}\&what=${SEARCH} -O ${PAGE}_SEXBOT_${count}
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.sexbot.com/main/search/videos/${SEARCH}/${count} -O ${PAGE}_SEXBOT_${count}			
		
		let count=$count-1
			
		done

#pull links out of downloaded file

#cat webpage_SEXBOT_* | grep -o 'href="[^*]*"' | grep -v http | awk -F '"' '/video/ { print "http://www.SEXBOT.com"$2 }' >> ${TODAY_OUTPUT_SEXBOT}
cat webpage_SEXBOT_* | grep -o 'href="[^*]*"' | grep video | awk -F '"' '/http/{ print $2 }' | awk '!a[$0]++'  >> ${TODAY_OUTPUT_SEXBOT}



# download links 



	for FASS in $(cat ${TODAY_OUTPUT_SEXBOT} ) ; do 
		echo "searching $FASS"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FASS -O ${TEMP_FILE_SEXBOT}
		FILE=$(cat ${TEMP_FILE_SEXBOT} |grep file | cut -d "'" -f4 )
		NAME=$(cat ${TEMP_FILE_SEXBOT} | grep "<title>" | cut -d ">" -f2 |  cut -d "|" -f1 | sed 's#\ #+#g')
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done



}

##########################################################################################################################################################################################

function tnaflix {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

#
# download all search pages

count=${COUNT:-3}
      	
		while [ ${count} -ge 0 ]
		do	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.tnaflix.com/search.php?page=${count}\&what=${SEARCH} -O ${PAGE}_TNAFLIX_${count}			
		
		let count=$count-1
			
		done

#pull links out of downloaded file

#cat webpage_TNAFLIX_* | grep -o 'href="[^*]*"' | grep -v http | awk -F '"' '/video/ { print "http://www.tnaflix.com"$2 }' >> ${TODAY_OUTPUT_TNAFLIX}

cat webpage_TNAFLIX_* | tr "'" "\n" | awk '/\/video/ && !/flixPlayerVideo/ { print "https://www.tnaflix.com"$0 }' | awk '!a[$0]++'  >> ${TODAY_OUTPUT_TNAFLIX}

# download links 



	for TNA_LINK in $(cat ${TODAY_OUTPUT_TNAFLIX} ) ; do 
		echo "searching $TNA_LINK" 
		youtube_command $TNA_LINK &
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $TNA_LINK -O ${TEMP_FILE_TNAFLIX}
		#FILE_URL=$(cat ${TEMP_FILE_TNAFLIX} |grep tnaflv2 | grep -v height | cut -d '"' -f2 )
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE_URL} -O ${TEMP_FILE_TNAFLIX}_2
		#FILE=$( cat ${TEMP_FILE_TNAFLIX}_2 | grep videoLink | cut -d ">" -f2 |  cut -d "<" -f1)
		#NAME=$(cat ${TEMP_FILE_TNAFLIX} | grep "<title>" | cut -d ">" -f2 |  cut -d "," -f1 | sed 's#\ #+#g' )
		#echo ${FILE}
		#echo ${NAME}
		check_names
		#echo ${NAME}
	
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_TNAFLIX} ${TEMP_FILE_TNAFLIX}*
rm ${TEMP_FILE_TNAFLIX}*

}

##########################################################################################################################################################################################

function fourtube {

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 0 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.4tube.com/find/videos/${SEARCH}\?sort=relevance\&page=${count} -O ${PAGE}_FOURTUBE_${count}			
		let count=$count-1
			
		done

#pull links out of downloaded file

cat $PAGE_FOURTUBE_* |  tr "<" "\n" | grep www.4tube.com/videos | cut -d '"' -f2 | grep ">"[A-Z] | awk '!a[$0]++' >> ${TODAY_OUTPUT_FOURTUBE}

# download links 



	for FOUR in $(cat ${TODAY_OUTPUT_FOURTUBE} ) ; do 
		echo "searching $T"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FOUR -O ${TEMP_FILE_FOURTUBE}
		FILE_URL=$(cat ${TEMP_FILE_FOURTUBE} | tr "<" "\n" | grep videoconfig | cut -d "'" -f4 | sed 's#config=##g' | sed 's#^#http://www.4tube.com#g')
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $FILE_URL -O ${TEMP_FILE_FOURTUBE}_2
		FILE=$( cat ${TEMP_FILE_FOURTUBE}_2 | tr "<" "\n" | grep file | grep http | cut -d ">" -f 2 )
	#	NAME=$(cat ${TEMP_FILE_FOURTUBE} | grep "<title>" | cut -d ">" -f2 |  cut -d "|" -f1 | sed 's#\ #+#g' )
		NAME=$(echo $FOUR | awk -F "/" '{ print $NF }' )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_FOURTUBE} ${TEMP_FILE_FOURTUBE}*
rm ${TEMP_FILE_FOURTUBE}*


}

##########################################################################################################################################################################################

function sunporno {

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')


# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 0 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.sunporno.com/search/${SEARCH}/page${count}.html -O ${PAGE}_sunporno_${count}			
		let count=$count-1
			
		done

#pull links out of downloaded file


cat $PAGE_sunporno_* |  grep -o 'href="[^*]*"' | grep video | cut -d '"' -f2 | awk '!a[$0]++' >> ${TODAY_OUTPUT_SUNPORNO}

# download links 



	for T in $(cat ${TODAY_OUTPUT_SUNPORNO} ) ; do 
		echo "searching $T"  
	#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O ${TEMP_FILE_SUNPORNO}
	#	FILE=$(cat ${TEMP_FILE_SUNPORNO} | grep flv | cut -d "'" -f4 )
	#	NAME=$(cat ${TEMP_FILE_SUNPORNO} | grep "<title>" | cut -d ">" -f2 |  cut -d "<" -f1 | sed 's#\ #+#g' )
	#	echo ${FILE}
	#	echo ${NAME}
	#	check_names
	#	echo ${NAME}
	
	#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		youtube_command $T &	
		download_manager
	done


#rm ${TODAY_OUTPUT_SUNPORNO} ${TEMP_FILE_SUNPORNO}
rm ${TEMP_FILE_SUNPORNO}

}

##########################################################################################################################################################################################

function mofo {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 0 ]
		do
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.mofosex.com/search/?query=${SEARCH}\&page=${count} -O ${PAGE}_mofo_${count}			
		let count=$count-1
			
		done

#pull links out of downloaded file

#cat ${PAGE}_mofo_* | grep video | grep href | grep -v div | grep class | grep -o 'href="[^*]*"' | cut -d '"' -f2 | awk '{ print "http://www.mofosex.com"$0 }' >> ${TODAY_OUTPUT_MOFO}
cat ${PAGE}_mofo_* | awk '/hiddenImages/ && /\/videos\// { print $0 }' | tr '"' "\n" | awk '/videos/ { print "https://www.mofosex.com"$0 }' >> ${TODAY_OUTPUT_MOFO}

# download links 

	for T in $(cat ${TODAY_OUTPUT_MOFO} ) ; do 
		echo "searching $T"  
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O ${TEMP_FILE_MOFO}
		#FILE=$(cat ${TEMP_FILE_MOFO} | grep flashvars.video_url | cut -d "'" -f2 | awk '{ gsub ("%3A",":"); 
		#		gsub ("%2F","/");
		#		gsub ("%3F","?"); 
		#		gsub ("%3D","=");
		#		gsub ("%3B",";")
		#		gsub ("%26","\\&"); print }' )
		#NAME=$(cat ${TEMP_FILE_MOFO} | grep flashvars.video_title | cut -d "'" -f2 | sed 's#\ #+#g' )
		#echo ${FILE}
		#echo ${NAME}
		#check_names
		#echo ${NAME}
	
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		youtube_command $T &

		download_manager
	done


#rm ${TODAY_OUTPUT_MOFO} ${TEMP_FILE_MOFO}
rm ${TEMP_FILE_MOFO}


}

##########################################################################################################################################################################################

function spankwire {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

DIRP=$(echo ${SEARCH} | cut -c1-24 )

#make directory for download and change to it

#mkdir ${DIRP}
#cd ${DIRP}
# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.spankwire.com/search/straight/keyword/${SEARCH}?Sort=Relevance\&Page=${count} -O ${PAGE}_spank_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file


#cat $PAGE_spank_* | grep -A 1 video_i  | grep -o 'href="[^*]*"' | cut -d '"' -f2 | grep -v javascript  >> ${TODAY_OUTPUT}

cat ${PAGE}_spank_* | grep video | grep href | grep -v div | grep class | grep -o 'href="[^*]*"' | cut -d '"' -f2 | awk '{ print "http://www.spankwire.com"$0 }' >> ${TODAY_OUTPUT_SPANK}

# download links 



#wget ${MYTH_WEBSITE} -O ${TODAY_OUTPUT}




	for T in $(cat ${TODAY_OUTPUT_SPANK} ) ; do 
		echo "searching $T"  
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O ${TEMP_FILE_SPANK}
		FILE=$(cat ${TEMP_FILE_SPANK} | grep flashvars.video_url | cut -d '"' -f2 | sed 's#%26#\&#g' )
		NAME=$(cat ${TEMP_FILE_SPANK} | grep flashvars.video_title | cut -d '"' -f2 )
		echo ${FILE}
		echo ${NAME}
		check_names
		echo ${NAME}
	
		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_SPANK} ${TEMP_FILE_SPANK}
rm ${TEMP_FILE_SPANK}

}

##########################################################################################################################################################################################

function tube8 {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-5}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.tube8.com/search.html\?q=${SEARCH}\&page=${count} -O ${PAGE}_TUBE8_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file


#cat $PAGE_TUBE8_* | grep -A 1 video_i  | grep -o 'href="[^*]*"' | cut -d '"' -f2 | grep -v javascript  >> ${TODAY_OUTPUT_TUBE8}
cat $PAGE_TUBE8_* | awk '/video-title-link|data-video_url/ { print $0 }' | tr '"' "\n" | grep https | awk '!a[$0]++'  >> ${TODAY_OUTPUT_TUBE8}


# download links 



#wget ${MYTH_WEBSITE} -O ${TODAY_OUTPUT}




	for T in $(cat ${TODAY_OUTPUT_TUBE8} ) ; do 
		echo "searching $T"  
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O ${TEMP_FILE_TUBE8}
		#FILE=$(cat ${TEMP_FILE_TUBE8} | grep videourl | grep flv | cut -d '"' -f2 )
		#NAME=$(cat ${TEMP_FILE_TUBE8} | grep flashvars.video_title | cut -d '"' -f2 )
		#NAME=$(cat ${TEMP_FILE_TUBE8} | grep "main-title main-sprite-img" | head -1 | cut -d ">" -f2 | sed 's#</h1##g' | sed 's#\ #_#g')
		#echo ${FILE}
		#echo ${NAME}
		#check_names 
		#echo ${NAME}
	
		youtube_command $T &

		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
		
		download_manager

	done


#rm ${TODAY_OUTPUT} ${TEMP_FILE}
rm ${TEMP_FILE}


}	

##########################################################################################################################################################################################

function pornhub {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.pornhub.com/video/search?search=${SEARCH}\&page=${count} -O ${PAGE}_PORNHUB_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

#cat $PAGE_PORNHUB_* | grep -o 'href="[^*]*"' | grep view_video | grep class=\"title | cut -d '"'  -f2 >> ${TODAY_OUTPUT_PORNHUB}

cat $PAGE_PORNHUB_* | awk -F '"' '/view_video.php\?viewkey/ { print "http://www.pornhub.com"$2 }' | grep viewkey | sed 's#http://www.pornhub.comhttps#https#g' >> ${TODAY_OUTPUT_PORNHUB}
 

# download links 


#	for T in $(cat ${TODAY_OUTPUT_PORNHUB} ) ; do 
	for VIDEO_URL in $(cat ${TODAY_OUTPUT_PORNHUB} ) ; do 
		echo "searching $T"  
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - |grep to.addVariable > ${TEMP_FILE_PORNHUB}
#		VIDEO_URL=$(wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - | awk -F '"' '/view_video.php\?viewkey/ { print "http://www.pornhub.com"$2 }')
#		FILE=$(grep video_url ${TEMP_FILE_PORNHUB} | cut -d '"' -f 4 | sed 's#%3Fr%3D100##g' | sed 's#%2F#/#g' | sed 's#%3A#:#g' | cut -d "%" -f1 )
#		NAME=$(grep video_title ${TEMP_FILE_PORNHUB} | cut -d '"' -f 4 )
#		echo ${FILE}
#		echo ${NAME}
#		check_names	
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &
                youtube_command ${VIDEO_URL} &
		download_manager
		
	done


#rm ${TODAY_OUTPUT} ${TEMP_FILE}
rm  ${TEMP_FILE}
}

##########################################################################################################################################################################################

function xvideos {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.xvideos.com/?k=${SEARCH}\&p=${count} -O ${PAGE}_XVIDEO_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

#cat ${PAGE}_XVIDEO_* | grep miniature | grep http | cut -d '"' -f2  >> ${TODAY_OUTPUT_XVIDEO}
#cat ${PAGE}_XVIDEO_* | grep http | cut -d '"' -f2 | grep /video[0-9] | awk '{ print "http://www.xvideos.com"$0 }'  >> ${TODAY_OUTPUT_XVIDEO} 


cat ${PAGE}_XVIDEO_* | awk -F '"' '/\/video[0-9]/ { print "http://www.xvideos.com"$12 }' >> ${TODAY_OUTPUT_XVIDEO} 


# download links 


	for T in $(cat ${TODAY_OUTPUT_XVIDEO} ) ; do 
		echo "searching $T"  

		youtube_command -i $T &

#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - | tr ";" "\n" | grep flv_url  > ${TEMP_FILE_XVIDEO}
#		FILE=$(cat ${TEMP_FILE_XVIDEO} | cut -d "=" -f2 | sed 's#%3Fr%3D100##g' | sed 's#%2F#/#g' | sed 's#%3A#:#g' | sed 's#%3F#?#g' | sed 's#%3D#=#g'| sed 's#%26#\&#g' )
#		NAME=$(echo $T | awk -F "/" '{ print $NF }')
#		echo ${FILE}
#		echo ${NAME}
#		check_names
#		echo ${NAME}
	
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.flv &

		
		download_manager
	done


#rm ${TODAY_OUTPUT_XVIDEO} ${TEMP_FILE_XVIDEO}
rm  ${TEMP_FILE_XVIDEO}

} 

##########################################################################################################################################################################################
 
function redtube {

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

# download all search pages

count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.redtube.com/mostrelevant?search=${SEARCH}\&page=${count} -O ${PAGE}_REDTUBE_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file


#cat ${PAGE}_REDTUBE_* | grep class=\"s\" | cut -d '"' -f2   >> ${TODAY_OUTPUT_REDTUBE}
#cat ${PAGE}_REDTUBE_* | awk -F '"' '/hide/ && /data-videoId/ { print "https://www.redtube.com/"$3 }' | awk '!a[$0]++'  >> ${TODAY_OUTPUT_REDTUBE}
cat ${PAGE}_REDTUBE_* | awk -F '"' '/hide/ && /data-videoId/ { print $3 }' | awk '!a[$0]++'  >> ${TODAY_OUTPUT_REDTUBE}


# download links 


	for T in $(cat ${TODAY_OUTPUT_REDTUBE} ) ; do 
		echo "searching $T"  
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://www.redtube.com/$T -O ${TEMP_FILE_REDTUBE}
		youtube_command https://www.redtube.com/$T &
#		FILE=$(cat ${TEMP_FILE_REDTUBE} | grep -o 'src="[^*]*"' | grep mp4 | cut -d '"' -f2 )
#		NAME=$(cat ${TEMP_FILE_REDTUBE} | grep videoTitle | cut -d ">" -f2 | cut -d "<" -f1 | tr " " "_")
#		echo ${FILE}
#		echo ${NAME}
#		check_names
#		echo ${NAME}
	
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.mp4 &
		
		download_manager
	done


#rm ${TODAY_OUTPUT_REDTUBE} ${TEMP_FILE_REDTUBE}
rm ${TEMP_FILE_REDTUBE}

}

##########################################################################################################################################################################################

function youjizz {

# download all search pages

SEARCH_JIZZ=$(echo ${SEARCH1} | sed 's#\ #-#g')
count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youjizz.com/search/${SEARCH_JIZZ}-${count}.html -O ${PAGE}_JIZZ_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

cat ${PAGE}_JIZZ_* | grep videos | egrep -v '(<Meta|http)' | cut -d "'" -f2 | sed 's#^/#http://www.youjizz.com/#g' | grep ^http | awk '!a[$0]++' >> ${TODAY_OUTPUT_JIZZ}


wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i ${TODAY_OUTPUT_JIZZ}_1 -O 



# download links 


	for T in $(cat ${TODAY_OUTPUT_JIZZ} ) ; do 
		echo "searching $T"  
#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - | grep -o "src='http:[^*]*'" | grep embed | cut -d "'" -f2 | awk '!a[$0]++' > ${TEMP_FILE_JIZZ}_1
	#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - | awk -F '"' '/videoplayer/ && /embed/ { print $4 }' > ${TEMP_FILE_JIZZ}_1

#		wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i ${TEMP_FILE_JIZZ}_1 -O - | grep 'so.addVariable("file"' | cut -d '"' -f4 > ${TEMP_FILE_JIZZ}
	#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i ${TEMP_FILE_JIZZ}_1 -O - | awk -F '"' '/so.addVariable\(\"file\"\,encodeURIComponent/ { print $4 }' > ${TEMP_FILE_JIZZ}
		NAMEN_JIZZ=$(echo $T | sed 's#.html$##g' | awk -F "/" ' { print $NF}')
		check_names
	#	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i ${TEMP_FILE_JIZZ} -O ${NAMEN_JIZZ}.flv & 
		youtube_command $T
		download_manager		
	done


#rm ${TODAY_OUTPUT_JIZZ} ${TEMP_FILE_JIZZ}*
rm ${TEMP_FILE_JIZZ}*

}

##########################################################################################################################################################################################

function xhamster {

# download all search pages

SEARCH_HAMSTER=$(echo ${SEARCH1} | sed 's#\ #+#g')
count=${COUNT:-2}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://xhamster.com/search.php\?q=${SEARCH_HAMSTER}\&page=${count} -O ${PAGE}_HAMSTER_${count}
			let count=$count-1
			
		done

#pull links out of downloaded file

#cat ${PAGE}_HAMSTER_* | grep -o 'href="[^*]*"' | grep movie | cut -d '"' -f2 | sed 's#^#http://xhamster.com#g' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HAMSTER}

#cat ${PAGE}_HAMSTER_* | tr '"' "\n" | awk '/movie/  { print $1 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HAMSTER}

cat ${PAGE}_HAMSTER_* | awk -F '"' '/class="video-thumb-info__name" href="/ { print $4 }' | awk '!a[$0]++' >> ${TODAY_OUTPUT_HAMSTER}


# download links 


	for T in $(cat ${TODAY_OUTPUT_HAMSTER} ) ; do 
		echo "searching $T"  
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" $T -O - |grep -A 4 flashvars > ${TEMP_FILE_HAMSTER}
		#SERVER=$(grep srv ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		#FILE=$(grep file ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		#IMAGE=$(grep image ${TEMP_FILE_HAMSTER} | cut -d "'" -f 4 )
		#check_names
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${IMAGE} 		
		#wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${SERVER}/key=${FILE} &
		youtube_command $T &		
		download_manager
	done


#rm ${TODAY_OUTPUT_HAMSTER} ${TEMP_FILE_HAMSTER}
rm ${TEMP_FILE_HAMSTER}


}

##########################################################################################################################################################################################

function all_sites {
	machinima &
	redtube &
	youjizz &
	xhamster &
	pornhub &
	xvideos &
	tube8 &
#	spankwire &
	mofo &
#	sunporno &
#	fourtube &
	tnaflix &
#	sexbot &
	yaptube &
	joggs &
	titworld &
	zbpoo &
	xanime &
	hqbutt &
	tubeclassic &
	spankbang &
	xnxx &
	hentaigasm &
	hentaihaven &
	shesfreaky &
	lieb &
	heavyr &
	yourporn &
	bestpeg &
	biguz &
	fetish &
	extremetube &
	strapatuer &
}


###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts c:CryjxXphfHEenMBuqzUYtNlbJTGIFQP:Smwa4s:R: option
do
	case $option in
		s) SEARCH1="${OPTARG}" ;;
		C) TUBECLASSIC=1 ;;
		w) TITWORLD=1 ;;		
		y) YAPTUBE=1 ;;
		r) REDTUBE=1 ;;
		T) TNAFLIX=1 ;;
		j) YOUJIZZ=1 ;;
		x) XVIDEO=1 ;;
		X) XANIME=1 ;;
                B) SPANKBANG=1 ;;
		p) PORNHUB=1 ;;
		h) XHAMSTER=1 ;;
		S) SPANKWIRE=1 ;;
		t) TUBE8=1 ;;
		m) MOFO=1 ;;
		z) ZBPORN=1 ;;
		M) MACHINIMA=1 ;;
		u) SUNPORNO=1 ;;
		4) FOURTUBE=1 ;;
		b) SEXBOT=1 ;;
		J) JOGGS=1 ;;
		q) HQBUTT=1 ;;
		H) HENTAIGASM=1 ;;
		E) HENTAIHAVEN=1 ;;
		f) SHESFREAKY=1 ;;
		l) LIEB=1 ;;
		Y) HEAVYR=1 ;;
		U) YOURP=1 ;;
		G) BESTP=1 ;;
		Q) STRAPATUER=1 ;;
		I) BIGUZ=1 ;;
		N) XNXX=1 ;;
		F) FETISH=1 ;;
		e) EXTREMETUBE=1 ;;
		P) JOGG_PORNSTAR=${OPTARG} ;;
		a) ALL=1 ;;
		R) RALE=${OPTARG} ;;
		n) NO_CLOBBER=1 ;;
		c) COUNT=${OPTARG} ;;
		*) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)

RATE=${RALE:-3}

if [ $(echo $SEARCH1 | wc -c) -le 2 ] && [ $(echo ${JOGG_PORNSTAR} | wc -c) -le 2 ] ; then 

	echo "What are you looking for today? "
	read SEARCH1

elif [ $(echo $SEARCH1 | wc -c) -le 2 ] && [ $(echo ${JOGG_PORNSTAR} | wc -c) -ge 3 ] ; then

	SEARCH1=${JOGG_PORNSTAR}

fi

# clean up search syntax and long filename

#SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

DIRP=$(echo ${SEARCH1} | sed 's#\ #_#g' | cut -c1-24 )

#make directory for download and change to it

mkdir ${DIRP}
cd ${DIRP}

rm -f .temp_*



# run the correct function


	if [ $REDTUBE -eq 1 ] ; then

		redtube
fi
	if [ $YOUJIZZ -eq 1 ] ; then
	
		youjizz
fi
	if [ $XVIDEO -eq 1 ] ; then
	
		xvideos
fi
	if [ $PORNHUB -eq 1 ] ; then
	
		pornhub
fi
	if [ $XHAMSTER -eq 1 ] ; then
	
		xhamster
fi
	if [ $TUBE8 -eq 1 ] ; then
	
		tube8
fi
	if [ $SPANKWIRE -eq 1 ] ; then
	
		spankwire
fi	
	if [ $MOFO -eq 1 ] ; then
	
		mofo
fi	
	if [ $SUNPORNO -eq 1 ] ; then
	
		sunporno
fi
	if [ $FOURTUBE -eq 1 ] ; then
	
		fourtube
fi
	if [ $TNAFLIX -eq 1 ] ; then

		tnaflix
fi
	if [ $SEXBOT -eq 1 ] ; then

		sexbot
fi
	if [ $YAPTUBE -eq 1 ] ; then

		yaptube
fi

	if [ $JOGGS -eq 1 ] ; then

		joggs
fi

	if [ $TITWORLD -eq 1 ] ; then

		titworld
fi

	if [ $MACHINIMA -eq 1 ] ; then
	
		machinima
fi
	
	if [ ${ZBPORN} -eq 1 ] ; then

		zbpoo
fi

	if [ ${XANIME} -eq 1 ] ; then

		xanime
fi

	if [ ${HQBUTT} -eq 1 ] ; then

		hqbutt
fi

	if [ ${TUBECLASSIC} -eq 1 ] ; then

		tubeclassic

fi
	if [ ${SPANKBANG} -eq 1 ] ; then

		spankbang

fi
	if [ ${XNXX} -eq 1 ] ; then

		xnxx

fi
	if [ ${HENTAIGASM} -eq 1 ] ; then

		hentaigasm

fi
	if [ ${HENTAIHAVEN} -eq 1 ] ; then

		hentaihaven

fi
	if [ ${SHESFREAKY} -eq 1 ] ; then

		shesfreaky

fi

	if [ ${LIEB} -eq 1 ] ; then

		lieb
fi
	if [ ${HEAVYR} -eq 1 ] ; then

		heavyr
fi
	if [ ${YOURP} -eq 1 ] ; then

		yourporn
fi
	if [ ${BESTP} -eq 1 ] ; then

		bestpeg
fi
	if [ ${BIGUZ} -eq 1 ] ; then

		biguz
fi
	if [ ${FETISH} -eq 1 ] ; then

		fetish
fi
	if [ ${EXTREMETUBE} -eq 1 ] ; then

		extremetube

fi
        if [ ${STRAPATUER} -eq 1 ] ; then

                strapatuer
fi

	if [ $ALL -eq 1 ] ; then
	
		all_sites

	fi








