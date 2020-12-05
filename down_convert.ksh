#!/bin/ksh

#FUNCTIONS and set VARIABLES

#get song title
function get_title {
mp3info2 -p %t $FILE
}
#get Artist
function get_artist {
mp3info2 -p %a $FILE
}
#get album name
function get_album {
mp3info2 -p %l $FILE
}
#get track number
function get_num {
mp3info2 -p %n $FILE
}
#down convert file
function down_convert {
FILE=$1
SONG=$(get_title)
ARTIST=$(get_artist)
ALBUM=$(get_album)
NUM=$(get_num)

lame --ignore-tag-errors --add-id3v2 --tt "${SONG}" --ta "${ARTIST}" --tl "${ALBUM}" --tn "${NUM}" --vbr-new -V 9 -B 160 $FILE ./DOWN_CONVERTED/$FILE
}

#PROGRAM

DUM=$(ls | grep -i mp3 | wc -l)
DUM2=$DUM

mkdir ./DOWN_CONVERTED
detox *

for MP3 in $(ls | grep -i mp3) ; do
        echo "converting ${DUM2} of ${DUM}..."
        down_convert $MP3
        let DUM2=$DUM2-1
done

