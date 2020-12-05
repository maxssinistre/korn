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
	app for downloading vids from dailymotion
	-i for interactive
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-l put the direct link to the page here. If nothing entered the script will ask you.
	-r use this to pull down related files that are on the same page. default is to not pull related down.
	-h this help document
	 	
"
exit 0
}

function download_manager {

			while [ $( ps -ef | grep w[g]et | grep -v defunct | wc -l ) -ge 2 ] ;do
				echo "waiting for download slots"
				sleep 30
			done
}

function check_names {

        if [ -z $REAL_NAME ] ; then
                REAL_NAME=dailymotion_vid_$RANDOM
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

TEMP_FILE=.temp_$RANDOM

URL=$@

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${URL} -O $TEMP_FILE

REAL_NAME=$(cat ${TEMP_FILE} | grep -o 'xml\"\ title=[^*]*' | head -1 | cut -d '=' -f 2| cut -d "'" -f1 | tr -d [:punct:] | tr -d [:cntrl:] | sed 's#\ #_#g' | sed 's#__#_#g'| sed 's#^_##g' | sed 's#_$##g' | tr -d [:space:])

DOWNLOAD_NAME=$(cat ${TEMP_FILE} | grep addVariable | tr "=" "\n" | 
			awk '{ gsub ("%3A",":");		
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
			gsub ("%22","\"");
			gsub ("%2C","\,");
			gsub ("%7B","\{");
			gsub ("%5B","\[");
			gsub ("%7D","\}");
			gsub ("%5D","\]");
			gsub ("%5C","\\");
			gsub ("%3C","\<");
			gsub ("%3E","\>");
			gsub ("%23","#");
			gsub ("%21","\!");
			gsub ("%25","%");
			print }' | 
			tr ":" "\n" | 
			grep auth= | 
			cut -d '"' -f1 | 
			tr -d "\\"  |
			sed 's#//www.dailymotion#http://www.dailymotion#g'
			)


check_names


wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${DOWNLOAD_NAME} -O ${REAL_NAME}.mp4

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

#get base video name

LAST_PART=$(echo ${LINK} | awk -F "/" '{print $NF }' )

BASE=$(echo ${LINK} | awk -F "/" '{print $NF }' | cut -d "_" -f1 )

echo $BASE

# download all page


wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.dailymotion.com/family_filter\?enable=false\&urlback=/video/${LAST_PART} -O ${PAGE}_${TODAY} 


#pull links out of downloaded file

if [ ${RELATED} -eq 0 ] ; then

REL_NUM=1

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.dailymotion.com/rated/related/${BASE}/${REL_NUM}?buzzableVideoId=${BASE}\&buzzableTitle=Sponsored%2520Video\&videoid=11439\&relatedtype=related\&related_algo=meta2-only\&af=1 -O related_${TODAY}


cat related_${TODAY} | grep -o 'href="[^"]*' |  awk '! a[$0]++' | grep '"/video/' | awk -F "/" ' { print "http://www.dailymotion.com/family_filter\?enable=false\&urlback=/video/"$NF }' >> ${CONFIG}


elif [ ${RELATED} -eq 1 ] ; then

cat ${PAGE}_${TODAY} | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep http | grep video | tr "\ " "\n" | awk -F "/" '{print "http://www.dailymotion.com/family_filter\?enable=false\&urlback=/video/"$NF }' | head -1 >> ${CONFIG}

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



