#!/bin/ksh

LIST=list.txt
DIR=PICS

mkdir $DIR

cd $DIR

wget -rkm www.trailgirl.blogspot.com

#grep -o 'href="[^"]*' www.trailgirl.blogspot.com/index.html | sed 's#href="##g' | egrep -i htm >> $LIST

grep -o 'src="[^"]*' www.trailgirl.blogspot.com/index.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST



cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST

grep -o 'src="[^"]*' *.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST

cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST
