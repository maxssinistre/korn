#!/bin/ksh

LIST=list.txt
DIR=PICS

mkdir $DIR

cd $DIR


wget http://bastardolifters.blogspot.com/index.html
grep -o "href='[^']*" index.html | sed "s#href='##g" | egrep -i '(jpg|gif|htm)' | awk '! a[$0]++' | grep -v '#' | grep -v widgetId >> $LIST
wget -nc -i $LIST
grep -o "src='[^']*" *.html | cut -d ":" -f2,3 | sed "s#src='##g" | egrep -i '(jpg|gif|png|wmv|mpg|avi)' | awk '! a[$0]++' >> $LIST
grep -o 'src="[^"]*' *.html | cut -d ":" -f2,3 | sed "s#src=\"##g" | egrep -i '(jpg|gif|png|wmv|mpg|avi)' | awk '! a[$0]++' >> $LIST
cat $LIST | awk '! a[$0]++' | sed 's#^//#http://#g' | sed 's#^../#http://bastardolifters.blogspot.com/#g' >> .temp
mv .temp $LIST

wget -nc -i $LIST

tar -cvzf archive_$RANDOM.tgz *.htm* $LIST

rm -f *.htm*

rm $LIST
