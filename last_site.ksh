#!/bin/ksh

echo "What is site link?"
read SIITE

cp ~/.dillo/dillo_last_site.txt ~/.dillo/dillo_last_site.txt_$(date +%Y%m%d%H%S)

echo "${SIITE}" >> ~/.dillo/dillo_last_site.txt 

cp ~/.dillo/dillo_last_site.txt ~/.dillo/.temp

cat ~/.dillo/.temp | awk '!a[$0]++' > ~/.dillo/dillo_last_site.txt

exit 0

