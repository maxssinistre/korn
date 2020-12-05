#!/bin/ksh

mkdir PICS

mkdir VIDEO

wget http://www.crossfit.com/

cat index.html | grep -o 'href="[^"]*' | egrep -i '(wmv|jpg|gif)' | sed 's#href="##g' | sed 's#-th##g' >> VIDEO/.list

cat index.html | grep -o 'src="[^"]*' | egrep -i '(wmv|jpg|gif)' | sed 's#src="##g' | awk '! /^\.\./ { print $0 }' | sed 's#-th##g' >> PICS/.list
 
cd VIDEO

wget -nc -i .list 

cd ../PICS

wget -nc -i .list 

cd ../

mv index.html $RANDOM.html

> .list
