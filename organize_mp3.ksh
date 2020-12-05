#!/bin/ksh

#This file sorts mp3's in a folder in separate folders according to the artist name	
	
#FUNCTIONS and set VARIABLES

#get song title
function get_title {
mp3info2 -p %t $FILE | tr "\ " "_" | tr -d ".,:;()/"
}
#get Artist
function get_artist {
mp3info2 -p %a $FILE | tr "\ " "_" | tr -d ".,:;()/"
}
#get album name
function get_album {
mp3info2 -p %l $FILE | tr "\ " "_" | tr -d ".,:;()/"
}
#get track number
function get_num {
mp3info2 -p %n $FILE | tr "\ " "_" | tr -d ".,:;()/"
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

DUM=$(ls | grep -i mp3 | wc -l)
DUM2=$DUM

for MP3 in $(ls | grep -i mp3)
	do
		echo "organizing ${DUM2} of ${DUM}..."	
		infarg $MP3
		mkdir -p ${ARTIST}/${ALBUM}
		mv $MP3 ${ARTIST}/${ALBUM}
		let DUM2=$DUM2-1
done
