#!/bin/ksh


CONFIG=.temp
PAGE=webpage
INTERACTIVE=0
NO_CLOBBER=0
PARR=2


#functions
function usage {

echo "
	app for downloading vids from youtube
	-i for interactive
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-c page count to download
	-p parralellism - how many downloads at once allowed
	-s put what you want to search for here. If nothing entered the script will ask you.
	   *note enclose searches with spaces in quotes	
	
"
exit 0
}

function download_manager {

#PARR=$0

		#	while [ $( ps -ef | grep w[g]et | grep -v defunct | wc -l ) -ge ${PARR} ] ;do
                        while [ $(ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial | wc -l ) -ge ${PARR} ] ;do
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

function get_vids_2 {

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

function get_vids {

TEMP_FILE=.temp_$RANDOM

URL=$@

#youtube-dl -v -t ${URL} 
youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4 -v -t ${URL} 

}


###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts p:c:ins: option
do
	case $option in
		s) SEARCH1="${OPTARG}" ;;
		i) INTERACTIVE=1 ;;
		n) NO_CLOBBER=1 ;;
		c) COUNT=${OPTARG} ;;
		p) PARR=${OPTARG} ;;
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

count=${COUNT:-0}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youtube.com/results\?search_type\=videos\&search_query\=${SEARCH}\&search_sort\=relevances\&uggested_categories\=17%2C25\&page\=${count} -O ${PAGE}_${count}

			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" http://www.youtube.com/results?search_query=${SEARCH}\&page=${count} -O ${PAGE}_${count}_b

#http://www.youtube.com/results?search_query=2011+paris+weightlifting&oq=2011+paris+weightlift&aq=0&aqi=g1&aql=&gs_sm=e&gs_upl=4696l12174l0l13851l21l18l0l4l4l2l695l4813l1.2.5.1.1.4l14l0

			let count=$count-1
			
		done

#pull links out of downloaded file

cat $PAGE* | grep watch | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep -v recently_watched | grep watch | sed 's#^#http://www.youtube.com#g' |grep -v all | cut -d "&" -f1 >> ${CONFIG}


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

tar -cvzf results_$RANDOM.tgz ${PAGE}_* .temp*

rm -f ${PAGE}_* .temp*


echo "your movie files are in the ${DIRP} directory"



