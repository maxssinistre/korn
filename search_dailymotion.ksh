#!/bin/ksh


CONFIG=.temp
PAGE=webpage
INTERACTIVE=0
NO_CLOBBER=0


#functions
function usage {

echo "
	app for downloading vids from youtube
	-i for interactive
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-c page count to download
	-s put what you want to search for here. If nothing entered the script will ask you.
	   *note enclose searches with spaces in quotes	
	
"
exit 0
}

function download_manager {

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
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts c:ins: option
do
	case $option in
		s) SEARCH1="${OPTARG}" ;;
		i) INTERACTIVE=1 ;;
		n) NO_CLOBBER=1 ;;
		c) COUNT=${OPTARG} ;;
		*) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)



if [ $(echo $SEARCH1 | wc -c) -le 2 ] ; then 

	echo "What are you looking for today? "
	read SEARCH1

elif [ ${INTERACTIVE} -eq 1 ] ; then
	
	echo "What are you looking for today? "
	read SEARCH1
#why is the above here again ????????	

fi

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

DIRP=$(echo ${SEARCH1} | sed 's#\ #_#g' | cut -c1-24 )

#make directory for download and change to it

mkdir ${DIRP}
cd ${DIRP}


# download all search pages

count=${COUNT:-1}
      	
		while [ ${count} -ge 1 ]
		do

		wget --user-agent='Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36' http://www.dailymotion.com/family_filter\?enable=false\&urlback=/relevance/search/${SEARCH}/${count} -O ${PAGE}_${count}

#http://www.dailymotion.com/relevance/search/kristina+milan/1
			let count=$count-1
			
		done

#pull links out of downloaded file

#cat $PAGE* | grep -o 'href="[^"]*' |  awk '! a[$0]++' | grep '"/video/' | awk -F "/" ' { print "http://www.dailymotion.com/family_filter\?enable=false\&urlback=/video/"$NF }' | sed 's#?search_algo=1##g' >> ${CONFIG}

#cat $PAGE* |grep -o 'href=[^*]*"' | awk -F '"' '/\/video\// { print "http://www.dailymotion.com"$2 }' | awk '!a[$0]++' | sed 's#?search_algo=1##g' >> ${CONFIG}

cat $PAGE* |grep -o 'href=[^*]*"' | awk -F '"' '/\/video\// { print "http://www.dailymotion.com"$2 }' | awk '!a[$0]++' >> ${CONFIG}



# download links


for FLV in $(cat ${CONFIG}) ;
do
		youtube-dl -v -t ${FLV} &
#		get_vids ${FLV} &
#		echo "filename is $FILE_NAME"
#		echo "real name is $REAL_NAME"
#		echo "download nam iis $DOWNLOAD_NAME"
		download_manager
done


# archive results files

tar -cvzf results_$RANDOM.tgz ${PAGE}_* .temp*

rm -f ${PAGE}_* .temp*


echo "your movie files are in the ${DIRP} directory"



