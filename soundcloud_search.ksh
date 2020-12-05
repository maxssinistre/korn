#!/bin/ksh


CONFIG=.temp
DATE=$(date +%Y%m%d%H%M%S)
ALBUM=0
SETS=0
TRACKS=0
EVERY=1

function usage {

echo "
	app for downloading from souncloud and searching
    -c page count to download
    -p parralellism - how many downloads at once allowed
    -s put what you want to search for here.
       *note enclose searches with spaces in quotes	
    -t to only download single tracks found
    -a to download albums
    -S to download playlists or sets
    -e everything - this is the default

	
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

function soundbox {

TYPE=$1
NUM=$2
SEARCHY=$3
count=0
UPDIR=$(echo ${TYPE} | tr [:lower:] [:upper:] )
mkdir ${UPDIR}
cd ${UPDIR}

        while [ $count -le ${NUM} ] ; do
            
#            wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://soundcloud.com/search/${TYPE}?q=eighteenth%20street%20lounge+page=${count} -O ${TYPE}_${count}.html
            wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" https://soundcloud.com/search/${TYPE}?q=${SEARCHY}+page=${count} -O ${TYPE}_${count}.html
            let count=$count+1

        done

cat *.html | awk -F '"' '/<li><h2><a href=/ { print "https://soundcloud.com"$2 }' | awk '!a[$0]++' >> ${TYPE}_output.txt

youtube-dl -v -t -i -a ${TYPE}_output.txt

}



###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts p:c:s:taSe option
do
	case $option in
		s) SEARCH1="${OPTARG}" ;;
		c) COUNT=${OPTARG} ;;
		p) PARR=${OPTARG} ;;
		a) ALBUM=1 ;;
        S) SETS=1 ;;
        t) TRACKS=1 ;;
        *) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)

# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #%20#g')

DIRP=$(echo ${SEARCH1} | sed 's#\ #_#g' | cut -c1-24 )

mkdir ${DIRP}

cd ${DIRP}

#if [ ${ALBUM} -eq 1 || ${SETS} -eq 1 || ${TRACKS} -eq 1 ] ; then

#    EVERY=0

#fi

[ ${ALBUM} -eq 1 ] && EVERY=0
[ ${SETS} -eq 1 ] && EVERY=0
[ ${TRACKS} -eq 1 ] && EVERY=0



if [ ${EVERY} -eq 1 ] ; then

    soundbox albums ${COUNT} ${SEARCH} &
    soundbox sounds ${COUNT} ${SEARCH} &
    soundbox sets ${COUNT} ${SEARCH} &

elif [ ${ALBUM} -eq 1 ] ; then

    soundbox albums ${COUNT} ${SEARCH} &

elif [ ${SETS} -eq 1 ] ; then

    soundbox sets ${COUNT} ${SEARCH} &

elif [ ${TRACKS} -eq 1 ] ; then

    soundbox sounds ${COUNT} ${SEARCH} &

fi
