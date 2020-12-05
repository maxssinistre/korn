#!/bin/ksh

function usage {

echo "

program to add links to IPTV plugin for emby and jellyfin


	-u the user to add in the xml - get this for the existing xml
	-c wher to start you count from
	-l the adtual link to add
	-f you can add a file also

}

###########################options

[ $# -lt 1 ] && usage

#test $( echo $@ | grep -o -i d ) && answer
echo $@

while getopts u:c:l:f: option
do

	case $option in
        u) USER="$OPTARG" ;;
        c) NUM="$OPTARG" ;;
        l) LINK="$OPTARG" ;;
	f) FILE_TEM="$OPTARG" ;;
	*) usage;;

	esac
done

shift $(expr $OPTIND - 1)

##########################################a

ps -ef | awk '{IGNORECASE=1} ; /jellyfin|emby/ { print $0 }'

echo '<?xml version="1.0"?>'
echo '<PluginConfiguration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
echo '  <Bookmarks>'

for CHAN in ${LINK} ; do 

echo "    <Bookmark>
      <Name>Channel_${NUM}</Name>
      <Image />
      <Path>${CHAN}</Path>
      <Protocol>Http</Protocol>
      <UserId>${USER}</UserId>
    </Bookmark>"
 

let NUM=$NUM+1

done
echo '  </Bookmarks>'

echo '</PluginConfiguration>'



