#!/bin/ksh


CONFIG=.temp
PAGE=webpage
INTERACTIVE=0


#functions
function usage {

echo "
	app for downloading vids from worldstarhiphop
	-i for interactive
	-n download files that have the same names from all sites, append random number ie: file_1234.flv
	-c page count to download
	-s put what you want to search for here. If nothing entered the script will ask you.
	   *note enclose searches with spaces in quotes	
	
"
exit 0
}

function download_manager {

			while [ $( ps -ef | grep w[g]et | wc -l ) -ge 2 ] ;do
				echo "waiting for download slots"
				sleep 10
			done
}		

function get_vids4 {

TEMP_FILE=.temp_$RANDOM

URL=$@

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${URL} -O $TEMP_FILE

	if [ $(cat $TEMP_FILE | grep worldstarAdultOk | wc -l ) -gt 0 ] ; then

		UNCUT_URL=$(cat $TEMP_FILE | awk -F '"' '/window.location/ { print "http://www.worldstaruncut.com"$8 }')
		
		wget --post-data 'worldstarAdultOk=1' --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${UNCUT_URL} -O ${TEMP_FILE}

	fi 

DOWNLOAD_NAME=$(cat $TEMP_FILE | awk -F '"' '/so.addVariable\(\"file/ { print $4 }')

#REAL_NAME=$(cat $TEMP_FILE | grep Video | grep title | cut -d ":" -f2 | cut -d "<" -f1 | awk '{ gsub ("^ ",""); gsub (" ","_"); gsub ("\"",""); gsub ("_$",""); print }')

REAL_NAME=$(cat $TEMP_FILE | grep \<title\> | cut -d ":" -f2 | awk '{ gsub ("<title>",""); gsub ("</title>",""); gsub ("^ ",""); gsub (" ","_"); gsub ("\"",""); gsub ("_$",""); print }')


wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${DOWNLOAD_NAME} -O ${REAL_NAME}.mp4


#rm $TEMP_FILE 

}

function get_vids4 {

TEMP_FILE=.temp_$RANDOM

URL=$@

youtube-dl -i -v -t ${URL} 

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

SEARCH=$(echo ${SEARCH1} | sed 's#\ #_#g')

DIRP=$(echo ${SEARCH1} | sed 's#\ #_#g' | cut -c1-24 )

#make directory for download and change to it

mkdir ${DIRP}
cd ${DIRP}


# download all search pages

count=${COUNT:-0}
      	
		while [ ${count} -ge 0 ]
		do
			wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" --post-data "SearchVideo=${SEARCH}" http://www.worldstarhiphop.com/videos/search.php -O ${PAGE}_${count}
			let count=$count-1
			
		done


#pull links out of downloaded file


cat $PAGE_* | grep video.php | grep _self | awk -F '"' '{print "http://www.worldstarhiphop.com/videos/"$6}' | awk '!a[$0]++' >> ${CONFIG}




#cat $PAGE_* | grep watch | grep -o 'href="[^"]*' |  awk '! a[$0]++' | sed 's#href="##g' | grep -v recently_watched | grep watch | sed 's#^#http://www.youtube.com#g' |grep -v all | cut -d "&" -f1 >> ${CONFIG}


# download links


for FLV in $(cat ${CONFIG}) ;
do
		get_vids ${FLV} &

		download_manager
done



# archive results files

tar -cvzf results_$RANDOM.tgz ${PAGE}_* .temp*

rm -f ${PAGE}_* .temp*


echo "your movie files are in the ${DIRP} directory"



function notes { 

#wget --user-agent="Mozilla" --post-data 'SearchVideo=minaj' http://www.worldstarhiphop.com/videos/search.php

#cat video.php* | awk -F '"' '/so.addVariable\(\"file/ { print $4 }'


#grep so.addVariable\(\"file *

#<title>Video:  On WSHH</title>
#        <link rel="stylesheet" type="text/css" href="styles/videoM.css">
#        <body style="background:#EFEFEF;">
#<div class="head">
#<div style="float:right;"><form name="form1" style="padding:0px;margin:0px;" method="post" action="search.php"><input name="SearchVideo" #style="border:none;height:15px;width:100px;" type="text" id="SearchVideo"><
#input name="Submit" type="submit" style="background:#000;color:#fff;border:none;height:20px;" value="Search"></form></div>
#<a href="http://www.worldstarhiphop.com/videos/">HOME</a> | <a href="http://www.worldstarcandy.com/">WSHH HONEYS</a> | <a href="http://www.worldstarhiphop.com/videos/partners.php">AFFILIATES</a> | <a href="http:/
#/www.worldstarhiphop.com/videos/contacts.php">CONTACT</a> | <a href="http://m.worldstarhiphop.com/">MOBILE</a> | <a href="http://www.worldstarhiphop.com/videos/rss.php">RSS</a>
#</div>


#http://www.worldstarhiphop.com/videos/search.php


#awk '{ gsub (" ","_"); gsub ("\"",""); print }'

#cat video.php\?v\=wshh* | grep Video | grep title | cut -d ":" -f2 | cut -d "<" -f1 | awk '{ gsub ("^ ",""); gsub (" ","_"); gsub ("\"",""); gsub ("_$",""); print }'



}
