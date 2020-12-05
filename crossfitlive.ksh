#!/bin/ksh

wget www.crossfitlive.com

cd www.crossfitlive.com

grep -o 'href="[^*]*"' archives.htm | grep -o 'prog[^*]*' | cut -d "'" -f1 | sed 's#^#http://www.crossfitlive.com/#' >> ../.list

cd ..

wget -rkm -i .list
