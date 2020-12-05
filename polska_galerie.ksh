#!/bin/ksh

#script for http://www.polska-sztanga.h2.pl/index.php weightlifting website


FILE=links
DATE=$(date +%M%S)
idIR=WORKING
AUTOMATED_LIST=.list_${DATE}


mkdir $idIR
cd $idIR

wget http://www.polska-sztanga.h2.pl/modules.php?name=coppermine

cat modules.php*| grep -o 'src="[^"]*' | grep -i jpg | sed 's#src="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST 

                                                                          
cat modules.php* | grep -o 'href="[^"]*' | grep modules.php | egrep '(News|display)' | sed 's#href="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST 

wget -nc -i $AUTOMATED_LIST



cat *.php* | grep -o 'src="[^"]*' | grep -i jpg | sed 's#src="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2

cat *.php* | grep -o 'href="[^"]*' | grep thumbnail | sed 's#href="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2 

cat *.php* | grep -o 'href="[^"]*' | grep file | sed 's#href="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2 

cat *.php* | grep -o 'href="[^"]*' | grep thumbnail | sed 's#href="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2 

cat *.php* | grep -o 'href="[^"]*' | grep file | sed 's#href="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2 

cat *.php* | grep -o 'src="[^"]*' | grep -i jpg | sed 's#src="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.2

wget -nc -i $AUTOMATED_LIST.2


cat *.php* | grep -o 'src="[^"]*' | grep -i jpg | sed 's#src="#http://www.polska-sztanga.h2.pl/#g' | awk '! a[$0]++' >> $AUTOMATED_LIST.3

wget -nc -i $AUTOMATED_LIST.3


cat $AUTOMATED_LIST.3 | sed 's#thumb_##g' >> $AUTOMATED_LIST.4

wget -nc -i $AUTOMATED_LIST.4


tar -cvzf $FILE_$DATE.tgz *.php* $AUTOMATED_LIST* thumbs_*

rm -f *.php* $AUTOMATED_LIST* thumbs_*
