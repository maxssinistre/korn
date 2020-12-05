#!/bin/ksh

TODAY=$(date +%Y%m%d%H%M%S)
CONFIG=.temp_${TODAY}
PAGE=webpage
INTERACTIVE=0
NO_CLOBBER=0
RELATED=1


#functions
function usage {

echo "
	app for downloading vids from youtube
	-i for interactive
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-l put the direct link to the page here. If nothing entered the script will ask you.
	-r use this to pull down related files that are on the same page. default is to not pull related down.
	-h this help document
	 	
"
exit 0
}

function download_manager {

#			while [ $( ps -ef | grep w[g]et | grep -v defunct | wc -l ) -ge 2 ] ;do
			while [ $( ps -ef | grep yout[u]be-dl | grep -v defunct | wc -l ) -ge 2 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
}

function check_names {

        if [ -z $REAL_NAME ] ; then
                REAL_NAME=yutube_vid_$RANDOM
        fi

		if [ -f ${REAL_NAME}.flv ] ; then
			if [ $NO_CLOBBER -eq 1 ] ; then		
				NAME=${REAL_NAME}_${RANDOM}
                	else
                        	echo " you already downloaded this"
                        	DOWNLOAD_NAME=""
                        	REAL_NAME=""

			fi
		fi

}	
function check_names1 {

#CLOBBER=$@

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
	

function get_vids {

URL=@

youtube-dl -v -t -i ${URL}

}

function get_vids_old {

TEMP_FILE=.temp_$RANDOM

URL=$@

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${URL} -O $TEMP_FILE

REAL_NAME=$(cat ${TEMP_FILE} | grep -o 'xml\"\ title=[^*]*' | cut -d '=' -f 2| cut -d "'" -f1 | tr -d "%20" | tr -d [:punct:] | tr -d [:cntrl:] | sed 's#\ #_#g' | sed 's#__#_#g'| sed 's#^_##g' | sed 's#_$##g' | tr -d [:space:])

DOWNLOAD_NAME=$(cat ${TEMP_FILE} | grep flashvar |  tr "=" "\n" | grep ^url | sed 's#^url%3D##g' | awk '{ gsub ("%3A",":");		
			gsub ("%2F","/"); 
			gsub ("%3F","?"); 
			gsub ("%3D","="); 
			gsub ("%3B",";"); 
			gsub ("%26","\\&"); 
			gsub ("%253A",":") ; 
			gsub ("%252F","/") ; 
			gsub ("%253F","?") ; 
			gsub ("%253D","=") ; 
			gsub ("%25252C","\,") ;
			gsub ("%2526","\\&");
			gsub ("%2522","\"");
			gsub ("%252C","\\,");
			gsub ("%253B","\\;");
			gsub ("%2B","+");
			print }' | sed 's#fallback_host=#\n#g' | head -1 )

check_names

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${DOWNLOAD_NAME} -O ${REAL_NAME}.flv

rm $TEMP_FILE 

}



###########################options
[ $# -lt 1 ] && INTERACTIVE=1 && echo "if you want usage, use -h. Starting interactive mode......"
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts inrhl: option
do
	case $option in
		l) LINK="${OPTARG}" ;;
		i) INTERACTIVE=1 ;;
		n) NO_CLOBBER=1 ;;
		r) RELATED=0 ;;
#		c) COUNT=${OPTARG} ;;
		h) usage;;
#		*) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)



if [ $(echo $SEARCH1 | wc -c) -le 0 ] ; then 

	echo "What is the link to the youtube page? "
	read LINK

elif [ ${INTERACTIVE} -eq 1 ] ; then
	
	echo "What is the link to the youtube page? "
	read LINK
#why is the above here again ????????	

fi

# clean up search syntax and long filename

#SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

#DIRP=$(echo ${SEARCH1} | sed 's#\ #_#g' | cut -c1-24 )

#make directory for download and change to it

#mkdir ${DIRP}
#cd ${DIRP}


# download all page

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${LINK} -O ${PAGE}_${TODAY}


#pull links out of downloaded file

if [ ${RELATED} -eq 0 ] ; then
#cat ${PAGE}_${TODAY} | grep watch? | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep -v recently_watched | grep watch | grep -v url | sed 's#^#http://www.youtube.com#g' |grep -v all | cut -d "&" -f1 >> ${CONFIG}
echo ${LINK} >> ${CONFIG}

elif [ ${RELATED} -eq 1 ] ; then
#cat ${PAGE}_${TODAY} | grep watch? | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep -v recently_watched | grep watch | grep -v url| sed 's#^#http://www.youtube.com#g' |grep -v all | cut -d "&" -f1 | head -1 >> ${CONFIG}
cat ${PAGE}_${TODAY} | awk -F'"' '/watch/ && /spf-link/ && /yt-uix-sessionlink/ && /data-visibility-tracking/ { print "http://www.youtube.com"$2 }' | awk '!a[$0]++' >> ${CONFIG}

fi 

# download links


for FLV in $(cat ${CONFIG}) ;
do
		get_vids ${FLV} &
		echo "filename is $FILE_NAME"
		echo "real name is $REAL_NAME"
		echo "download nam iis $DOWNLOAD_NAME"
		download_manager
done


# archive results files

tar -cvzf results_${TODAY}.tgz ${PAGE}_${TODAY} .temp*

rm -f ${PAGE}_${TODAY}


echo "your movie files are in the ${DIRP} directory"



