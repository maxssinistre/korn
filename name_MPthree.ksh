#!/bin/ksh

#This file renames mp3 acording to idtag name

#FUNCTIONS and set VARIABLES

#get song title
function get_title {
mp3info2 -p %t $FILE | tr "\n" "_" | awk 'BEGIN { FS = ":" } { print $NF }' | sed 's#^\ ##g' | sed 's#^_##g'| tr -d [:punct:] | tr "\ " "_"
}
#get Artist
function get_artist {
mp3info2 -p %a $FILE | tr "\n" "_" | awk 'BEGIN { FS = ":" } { print $NF }' | sed 's#^\ ##g' | sed 's#^_##g'| tr -d [:punct:] | tr "\ " "_"
}
#get album name
function get_album {
mp3info2 -p %l $FILE | tr "\n" "_" | awk 'BEGIN { FS = ":" } { print $NF }' | sed 's#^\ ##g' | sed 's#^_##g'| tr -d [:punct:] | tr "\ " "_"
}
#get track number
function get_num {
mp3info2 -p %n $FILE | tr "\n" "_" | awk 'BEGIN { FS = ":" } { print $NF }' | sed 's#^\ ##g' | sed 's#^_##g'| tr -d [:punct:] | tr "\ " "_"
}
#down get info
function infarg {
FILE=$1
SONG=$(get_title)
ARTIST=$(get_artist)
ALBUM=$(get_album)
NUM=$(get_num)
}

detox *

for MP3 in $(ls | grep -i mp3)
        do
                infarg $MP3
		echo "Renaming ${MP3} to ${SONG}"
                mv $MP3 ${SONG}.mp3
done
