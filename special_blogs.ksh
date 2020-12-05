#!/bin/ksh

mkdir PICS
mkdir ARCH
>./PICS/.list

wget $@
wget $@ -O index.html

SITE=$(grep guest blogin* | grep -o 'href="[^*]*"' | cut -d '"' -f2)

wget $SITE

if [ $(ls *.php* | wc -l ) -gt 0 ] ; then
        wget $@ -O index.html
elif [ $(echo $SITE | grep tumblr | wc -l ) -ge 1 ] ; then
	wget --save-cookies coookies.txt --keep-session-cookies --post-data='username=artemis.fire.808@gmail.com&password=PBJtim3!' $SITE -O index.html
fi

#grep -o 'src="[^*]*"' *.htm* | grep jpg | tr ";" "\n" | grep -o 'src="[^*]*"' | cut -d '"' -f2 | sed 's#+copy##g' | sed 's#_p.jpg#.jpg#g' | sed 's#_q.jpg#.jpg#g' | sed 's#.thumbnail##g' | sed 's#_thumb.jpg#.jpg#g' | sed '#/tn_#/#g' | sed 's#/th_#/#g' | sed 's#s200#s1600#g' | awk '!a[$0]++' >>./PICS/.list

grep -o 'src="[^*]*"' *.htm* | egrep -i '(gif|jpg)' | tr ";" "\n" | grep -o 'src="[^*]*"' | cut -d '"' -f2 | sed 's#+copy##g' | sed 's#_p.jpg#.jpg#g' | sed 's#_q.jpg#.jpg#g' | sed 's#.thumbnail##g' | sed 's#_thumb.jpg#.jpg#g' | sed '#/tn_#/#g' | sed 's#/th_#/#g' | sed 's#s200#s1600#g' | sed  's#-[0-9][0-9][0-9]x[0-9][0-9][0-9].jpg$#.jpg#g' | sed  's#_[0-9][0-9][0-9]x[0-9][0-9][0-9].jpg$#.jpg#g' | awk '!a[$0]++' >>./PICS/.list

#for reddit pics

cat *.html | tr '"' "\n" | awk '{IGNORECASE=YES} ; /jpg|jpeg|gif|mp4|m4v/ && !/preview.redd|b.thumbs.redditmedia/ && /http/ { print $0 }' | awk '!a[$0]++' >>./PICS/.list


# the order is important, the below parse is for the smaller files, only usefull is the large ones were not retrieved , the files have the same names differant sizes

grep -o 'src="[^*]*"' *.htm* | egrep -i '(gif|jpg)' | tr ";" "\n" | grep -o 'src="[^*]*"' | cut -d '"' -f2 | awk '!a[$0]++' >>./PICS/.list

#for the video files that are embedded in tumblr

cat *.htm* | tr "\\" "\n" | grep video_file | sed 's#x22##g' >> ./PICS/tumblr_vids

#added for imagevenue pics -- might work
for LINK in $(grep -o 'href="[^*]*"' *.html* | grep imagevenue | tr ";" "\n" | tr '"' '\n' | grep php | grep -i jpg | grep "^http") ; do 
        HEAD=$(echo ${LINK} | cut -d "/" -f1,2,3)  
#        echo $HEAD  
        PIE=$(wget -O - "${LINK}"  2> /dev/null | grep -o 'SRC="[^*]*"' | cut -d '"' -f2)  
#        echo $PIE  
        URB=$(echo $HEAD/$PIE | grep -i jpg)
        echo $URB
#        wget $URB
#end section
done >> ./PICS/.list

cat ./PICS/.list | awk '!a[$0]++' >> .tmep

mv .tmep ./PICS/.list

mv index* blogin* *.php* ARCH/

cd PICS
wget --tries=2 --timeout=10 -nc -i .list

for FILE in $(cat tumblr_vids ) ; do

	NAME=$(echo ${FILE} | awk -F "/" '{ print $NF }')
	wget -nc --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4)" ${FILE} -O ${NAME}.mp4

done
