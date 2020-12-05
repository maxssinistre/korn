#!/bin/ksh

DATE=$(date +%M%S)
HARM=WORKING

mkdir $HARM

cd $HARM

tar -xvzf files*.tgz
rm -f .list
rm -f files*.tgz

NUMBER=2325
      	
		while [ ${NUMBER} -gt 2320 ]
		do
			wget -nc http://www.ironmind.com/ironcms/morenewsv6.php?id=${NUMBER}
			let NUMBER=$NUMBER-1
		done

grep -o 'href="[^*]*"\ target' morenewsv6.php\@id\=* | grep jpg | sed 's#href="#http://www.ironmind.com#g' | cut -d "\"" -f1 | cut -d ":" -f2,3,4 >> .list

wget -nc -i .list

tar -cvzf files_$DATE.tgz morenewsv6.php\@id\=* .list

rm -f morenewsv6.php\@id\=* .list
