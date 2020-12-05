#!/bin/ksh

DATE=$(date +%M%S)
HARM=WORKING

mkdir $HARM

cd $HARM

NUMBER=2341
GUESS=1

wget -nc http://www.ironmind.com/ironcms/morenewsv6.php?id=$((${NUMBER}-1))
      
                while [ ${GUESS} -ne 0 ]
                do
                        wget -nc http://www.ironmind.com/ironcms/morenewsv6.php?id=${NUMBER}
                                FIRST=$(ls -ltr morenewsv6.php\@id\=${NUMBER}| awk '{ print $5 }') 
                                SECOND=$(ls -ltr morenewsv6.php\@id\=$((${NUMBER}-1))| awk '{ print $5 }')
                        GUESS=$((${FIRST}-${SECOND}))
                        echo $GUESS
                        let NUMBER=$NUMBER+1
                done

grep -o 'href="[^*]*"\ target' morenewsv6.php\@id\=* | grep jpg | sed 's#href="#http://www.ironmind.com#g' | cut -d "\"" -f1 | cut -d ":" -f2,3,4 >> .list

wget -nc -i .list

tar -cvzf files_$DATE.tgz *.php* .list

rm -f morenewsv6.php\@id\=* .list

