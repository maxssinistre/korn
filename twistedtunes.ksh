#!/bin/ksh
#Twisted tunes download

WORKING=TwittedTunes

mkdir $WORKING
cd $WORKING

wget http://www.98online.com/pages/music_tunes.aspx

grep -o 'href="[^*]*' *.asp* | egrep -i '(mp3|ram)' | cut -d '"' -f2 | sed 's#\ #\\ #g' | sed 's#\.\./#http://www.98online.com/#g' | awk '! a[$0]++' >> .list
#grep -o 'href="[^*]*' *.asp* | egrep -i '(mp3|ram)' | cut -d '"' -f2 | sed 's#\ #\\ #g' | sed 's#\.\./#http://www.98online.com/pages/#g' | awk '! a[$0]++' >> .list

wget -nc -i .list
