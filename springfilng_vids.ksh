#!/bin/ksh

#make needed directories

mkdir VIDEO

mkdir PICS

#video section

cd VIDEO

wget http://www.98online.com/springfling/videos/index.html

#cat index.html | grep -o 'href="[^*]*"' | grep -o "([^*]*)"

cat index.html | grep flv | grep -o 'href="[^*]*"' | grep -o "'[^*]*'" | tr -d "'" | sed 's#^#http://www.98online.com/springfling/videos/flv/#g' | awk '! a[$0]++' >> .temp

wget -nc -i .temp

rm .temp index.html

cd -

#picture section

cd PICS

wget http://www.98online.com/springfling/photos/index.html

cat index.html | grep -o 'href="[^*]*"' | cut -d '"' -f2 | grep -i jpg | sed 's#^../#http://www.98online.com/springfling/#g' | awk '! a[$0]++' >> .temp2

wget -nc -i .temp2

rm .temp2 index.html

cd -






