#!/bin/ksh

LIST=links.txt
WORKING=PICS
POS=KING
DAITE=$(date +%Y%m%d%A%b%R)

archive.ksh -s

mkdir $WORKING
mkdir $POS

wget -rkm -np http://picasaweb.google.com/JoePru/
#have to do this twice to get the html document
wget -rkm -np http://picasaweb.google.com/JoePru/

find ./picasaweb.google.com/ -type f -exec cat {} \; | grep ggpht | grep -o 's:"[^*"]*' | awk '!a[$0]++' | sed 's#^s:\"##g' >> $WORKING/$LIST

cd $WORKING

cat $LIST | sed 's#\\x2F#\/#g' >> .temp

mv .temp $LIST

wget -nc -i $LIST

#detox *

wget -rkm -i $LIST

mv $LIST $LIST_old_$RANDOM

cd -

rm -rf ./picasaweb.google.com/

archive.ksh -u

mv $WORKING/*.jpg $POS/
mv $WORKING/*.JPG $POS/
