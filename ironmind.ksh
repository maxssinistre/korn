#!/bin/ksh

DATE=$(date +%M%S)
HARM=WORKING

mkdir $HARM

cd $HARM

wget http://74.205.126.46/ironcms/newscolumn.php

NUMBER=$(cat newscolumn.php | grep -o 'http:[^*]*' | grep more | head -1 | cut -d "=" -f2 | cut -d "&" -f1 | tr -d [:cntrl:])

wget -nc http://www.ironmind.com/ironcms/morenewsv6.php?id=$((${NUMBER}-1))
      
                while [ ${NUMBER} -ge 2470 ]
                do
                        wget -nc http://www.ironmind.com/ironcms/morenewsv6.php?id=${NUMBER}
                        let NUMBER=$NUMBER-1
                done

grep -o 'href="[^*]*"\ target' morenewsv6.php\@id\=* | grep jpg | sed 's#href="#http://www.ironmind.com#g' | cut -d "\"" -f1 | cut -d ":" -f2,3,4 >> .list

wget -nc -i .list

tar -cvzf files_$DATE.tgz *.php* .list

rm -f *.php* .list

