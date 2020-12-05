#!/bin/ksh

LIST=list.txt
DIR=dir_$RANDOM
WEBSIR=$@

mkdir $DIR

cd $DIR

#wget -rkm $WEBSIR/index.html
wget $WEBSIR/index.html

grep -o 'href="[^"]*' $WEBSIR/index.html | sed 's#href="##g' | egrep -i htm >> $LIST

grep -o 'src="[^"]*' $WEBSIR/index.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST



cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST

grep -o 'src="[^"]*' *.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST

cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST
