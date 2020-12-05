#!/bin/ksh

LIST=list.txt
DIR=dir_$RANDOM
WEBSIR=http://lostturntable.blogspot.com

mkdir $DIR

cd $DIR

#wget -rkm $WEBSIR/index.html
wget $WEBSIR/index.html

#grep -o 'href="[^"]*' $WEBSIR/index.html | sed 's#href="##g' | egrep -i htm >> $LIST
#grep -o 'href=.[^"]*' index.html | sed 's#href="##g' | egrep -i htm >> $LIST

#grep -o 'src="[^"]*' $WEBSIR/index.html | sed 's#src="##g' | egrep -i '(mp3)' >> $LIST
#grep -o 'src=.[^"]*' index.html | sed 's#src="##g' | egrep -i '(mp3)' >> $LIST

grep -o 'href="[^"]*' index.html | grep mp3 | sed 's#href="##g' >> $LIST


cat $LIST | awk '! a[$0]++' | cut -d "'" -f2 >> .temp
mv .temp $LIST

wget -nc -i $LIST

grep -o 'src="[^"]*' *.html | sed 's#src="##g' | egrep -i '(mp3)' >> $LIST

cat $LIST | awk '! a[$0]++' |  cut -d "'" -f2 >> .temp
mv .temp $LIST

wget -nc -i $LIST
