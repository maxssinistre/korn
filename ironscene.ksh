#!/bin/ksh

LIST1=.temp
LIST2=.temp2
LIST3=.temp3

echo " What are you searching for ?"
read TMP

SEARCH=$(echo ${TMP} | sed 's#\ #+#g')

mkdir $SEARCH

cd $SEARCH
mkdir PAGES
mkdir PHP

wget http://www.ironscene.com/search.php\?page\=1\&keyword=${SEARCH}
wget http://www.ironscene.com/search.php\?page\=2\&keyword=${SEARCH}
wget http://www.ironscene.com/search.php\?page\=3\&keyword=${SEARCH}

cat *.php* | grep -o 'href="[^*]*" ' | grep width | grep video | cut -d '"' -f2 >> PAGES/$LIST1

mv *search.php* PHP/

cd PAGES

wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -nc -i $LIST1

#grep explay *.htm | grep -o 'config=[^*]*' | cut -d '&' -f1

for PAGE in $(ls) ; do
	grep explay $PAGE | grep -o 'config=[^*]*' | cut -d '&' -f1 | sed 's#config=##g' > $LIST2
	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -i $LIST2 -O .bababa.htm
	cat .bababa.htm | grep -o '<file[^*]*.flv' | sed 's#<file>##g' > $LIST3
	wget --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" -nc -i $LIST3 -O $PAGE.flv
	mv *.flv ../
done

cd ..
 archive.ksh -bd

#tar -cvzf archive_$RANDOM.tgz $LIST1 $LIST2 $LIST3 *.php*

#mv *.php* PHP/

#rm $LIST1 $LIST2 $LIST3 *.php*
