#!/bin/ksh

mkdir WORKING
cd WORKING

wget http://www.98online.com/pages/jocks_mas.aspx
grep -o 'href="[^*]*' jocks_mas.asp* | grep wmv | cut -d '"' -f2 | sed 's#^..#http://www.98online.com#g' | awk '! a[$0]++' >> .list
wget -nc -i .list
 
tar -cvzf archive_$RANDOM.tgz *.asp* .list*
rm *.asp*
rm .list*

cd -

mkdir PICS
cd PICS
wget http://www.98online.com/pages/jocks_mas_chicks.aspx
wget http://www.98online.com/pages/jocks_mas_events.aspx
wget http://www.98online.com/pages/jocks_mas_bands.aspx
wget http://www.98online.com/pages/jocks_mas_guests.aspx
wget http://www.98online.com/pages/jocks_mas_family.aspx

grep -o 'href="[^*]*' *.asp* | grep -i aspx | grep -i Click | cut -d '"' -f2 | sed 's#^#http://www.98online.com/pages/#g' | awk '! a[$0]++' >> .list2
wget -nc -i .list2
grep -o 'src="[^*]*' *.asp* | grep -i jpg | cut -d '"' -f2 | sed 's#^..#http://www.98online.com#g' | awk '! a[$0]++' >> .list3
cat .list3 | sed 's#TN.jpg#.jpg#g' >> .list4
wget -nc -i .list4

tar -cvzf archive_$RANDOM.tgz *.asp* .list*
rm *.asp*
rm .list*

cd -
