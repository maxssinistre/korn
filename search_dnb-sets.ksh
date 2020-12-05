#!/bin/ksh

rm -f index.*

DATE=$(date +%Y%m%d%H%M%S)

DATAFILE=suche

echo " What artist should i search for? (note use + for spaces) "
read ARTIST

WEBSITE0=http://www.dnb-sets.de/?suche=$ARTIST
WEBSITE1=http://www.dnb-sets.de/\?start=12\&suche=$ARTIST
WEBSITE2=http://www.dnb-sets.de/\?start=24\&suche=$ARTIST

#WEBSITE=$@

mkdir $ARTIST

cd $ARTIST

wget $WEBSITE0
wget $WEBSITE1
wget $WEBSITE2

for WEBFILE in $(ls index.*) ; do

perl -ne 'if (/href="([^"]*)"/) { print "$1\n"; }' $WEBFILE | grep -i mp3 >> $DATAFILE

perl -ne 'if (/src="([^"]*)"/) { print "$1\n"; }' $WEBFILE | grep -i mp3 >> $DATAFILE

cat $WEBFILE | grep -o 'http://[^"]*' | grep -i mp3 >> $DATAFILE

done

cat $DATAFILE | awk '! a[$0]++' >> .temp

mv .temp $DATAFILE

wget -nc -i $DATAFILE

mv ${DATAFILE} ${DATAFILE}_${DATE}.old

