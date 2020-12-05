#!/bin/ksh

LIST=list.txt
DIR=PICS

mkdir $DIR

cd $DIR

wget -rkm www.gwenweightlifting.blogspot.com

#grep -o 'href="[^"]*' www.gwenweightlifting.blogspot.com/index.html | sed 's#href="##g' | egrep -i htm >> $LIST

grep -o 'src="[^"]*' www.gwenweightlifting.blogspot.com/index.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST



cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST

grep -o 'src="[^"]*' *.html | sed 's#src="##g' | egrep -i '(jpg|gif|htm)' >> $LIST

cat $LIST | awk '! a[$0]++' >> .temp
mv .temp $LIST

wget -nc -i $LIST

tar -cvzf archive_$RANDOM.tgz *.htm* *.txt www.*
rm -rf *.htm* *.txt www.*
