#!/bin/ksh

#ask the question
echo " What are you looking for today , you perv ! "
read SEARCH1


# clean up search syntax and long filename

SEARCH=$(echo ${SEARCH1} | sed 's#\ #+#g')

DIRP=$(echo ${SEARCH} | cut -c1-24 )

mkdir $DIRP

cd $DIRP

#download the 1st search page

wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=00
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=10
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=20
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=30
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=40
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=50
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=60
wget http://www.eskimotube.com/show.php\?search=${SEARCH}\&offset=70


#pull out the individual webpages for link processing and download

cat show.php\?search\=* | grep -o 'href=[^*]*' | grep html | grep src | cut -d "'" -f2 | awk '!a[$0]++' | sed 's#^#http://www.eskimotube.com#g' >> .list

wget -nc -i .list

#pull out the flv links

cat *.html | grep -o 'url:[^*]*' | grep flv | cut -d "'" -f2 >> .list2

wget -nc -i .list2


tar -cvzf archive_$RANDOM.tgz *.php* .list* *.html

rm -f *.php* .list* *.html 

cd -
