#!/bin/ksh

TODAY=$(date +%b%a%d%y) 

START_DIR=$@

#cd $START_DIR

mkdir REAL_COVERTED_${TODAY}

for WAV in $(ls *.ra) ; do
        
        TITLE=$(echo ${WAV} | cut -d "." -f 1)
#        mplayer -vc dummy -vo null -idx $WAV -ao pcm:file=temp.wav
        mplayer -vc null -vo null -idx $WAV -ao pcm:fast:file=temp.wav
        cat temp.wav | lame --tt ${TITLE} --ta 1xtra -h --vbr-new -V 9 -B 160 - - > ./REAL_COVERTED_${TODAY}/${TITLE}.mp3
        rm temp.wav

done

