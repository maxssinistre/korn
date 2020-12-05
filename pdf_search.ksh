#!/bin/ksh


echo " What pdf's are you looking for?"
read SEAR

SEARCH=$(echo $SEAR | sed 's#\ #-#g')

mkdir $SEARCH
cd $SEARCH

wget http://www.pdfgeni.com/ref/${SEARCH}-pdf.html

grep -o 'href=[^*\ ]*' *.html | egrep -v '(pdfurl|FriendlyDuck.co|")' | cut -d "=" -f2 >> .list

wget -i .list

cd -
