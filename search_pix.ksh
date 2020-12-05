#!/bin/ksh


function usage {
	echo "script to pull files from pixmac or google (hopefully) and store them in an itemized folder
	-s this is what you want to search for
	-g use google
	-p use pixmac for the pics
	-b pull from both. do NOT use with -g or -p !!!
	-h print usage
	-S Superiorpics - use only for celebrity stuff - variable results
"	
	exit 0
}

TODAY=$(date +%m%d%y%H%M%S)

function interact {

echo " what pics do you want ?"
read SEARCH_DIRTY

}


function pixmac {
NUM=1
ARCHIVE_FOLDER=ARCV

mkdir ${SEARCH}

cd ${SEARCH}
mkdir ${ARCHIVE_FOLDER} > /dev/null

wget http://www.pixmac.com/pictures/${SEARCH} -O ${SEARCH}_pixmac_page${NUM}.html

while [ $(grep "Next page" ${SEARCH}_pixmac_page${NUM}.html | head -1 | grep -v display:none | wc -l ) -ge 1 ] ; do

        wget $(grep Next  ${SEARCH}_pixmac_page${NUM}.html | head -1 | cut -d '"' -f4 | awk '{print "http://www.pixmac.com"$0 }' ) -O temp
        mv  ${SEARCH}_pixmac_page${NUM}.html ${ARCHIVE_FOLDER}/
        let NUM=${NUM}+1
        mv temp  ${SEARCH}_pixmac_page${NUM}.html
			if [ ${NUM} -gt 20 ]
			then
				break
			fi	

done

grep jpg ${ARCHIVE_FOLDER}/*.html | grep -o 'http:[^*]*' | tr "'" "\n" | grep jpg | grep -v cloudfront | cut -d '"' -f1 | awk '!a[$0]++' >> .list

wget --user-agent=Mozilla -nc -i .list
#mv ${ARCHIVE_FOLDER}/* ./
#rm -rf ${ARCHIVE_FOLDER}




}

function google {
NUM=1
ARCHIVE_FOLDER=ARCV

mkdir ${SEARCH}

cd ${SEARCH}
mkdir ${ARCHIVE_FOLDER} > /dev/null

BLAH=9
HALB=0

while [ $BLAH -ge 1 ] ; do

	wget --user-agent="Firefox" http://www.google.com/search?q=${SEARCH}\&hl=en\&client=firefox-a\&rls=org.mozilla:en-US:official\&sout=1\&tbm=isch\&ei=v9LCTdycMYrHgAef1qDLAQ\&sa=N\&start=${HALB}\&ndsp=20\&biw=1272\&bih=839 -O ${SEARCH}_google_page_${BLAH}.html
	let HALB=$HALB+20
	let BLAH=$BLAH-1

done
	
	
cat ${SEARCH}_google_page* | tr '"' '\n' | tr "=" "\n" | tr "=" "\n" | grep imgrefurl | cut -d "&" -f1 | awk '!a[$0]++' | sed 's#%3F#\?#g' >> .list


cat .list | awk '!a[$0]++' > .tttttttt

mv .tttttttt .list

wget --tries=2 --user-agent=Mozilla -i .list
}

function superior {

#to search and download pics from superiorpics website


NUM=1
ARCHIVE_FOLDER=ARCV

mkdir ${SEARCH}

cd ${SEARCH}
mkdir ${ARCHIVE_FOLDER} > /dev/null

wget --user-agent="Firefox" http://www.google.com/search?ie=UTF-8\&oe=UTF-8\&domains=superiorpics.com\&sitesearch=superiorpics.com\&q=${SEARCH}\&x=0\&y=0 -O ${SEARCH}_google_main_page.html


cat ${SEARCH}_google_main_page.html | tr '"' '\n' | tr "=" "\n" | tr "=" "\n" | grep -a5 "Picture Pages" | grep ^http | grep -v html >> .list

cat .list | awk '!a[$0]++' > .tttttttt

mv .tttttttt .list

for WEBLINK in $( cat .list) ; do
	
	HERM=$(pwd)
	FOLDER=$(echo ${WEBLINK} | rev | awk -F "/" '{ print $2 }' | rev )
	mkdir $FOLDER
	cd $FOLDER
	wget --tries=2 --user-agent=Mozilla ${WEBLINK} -O ${FOLDER}_google.html
	cat ${FOLDER}_google.html | tr ">" "\n" | grep pictures | grep -v meta | cut -d " " -f2 | sed 's#href=#http://www.superiorpics.com#g' >> .${FOLDER}_temp
	wget --tries=2 --user-agent=Mozilla -i .${FOLDER}_temp
	cat pictures[0-9].html | tr ">" "\n" |grep -o 'src="[^*]*"' | grep jpg | egrep -v '(imagesV2|http|iframe)' | cut -d '"' -f2 | sed 's#^#http://www.superiorpics.com#g' | sed 's#thumb/##g' | awk '!a[$0]++' > .${FOLDER}_pics
	wget -nc --tries=2 --user-agent=Mozilla -i .${FOLDER}_pics
	tar -cvzf .${FOLDER}_archive.tgz *.html 
	rm -f .${FOLDER}_pics .${FOLDER}_temp *.html
	cd $HERM
done
}

function cleanup {

#cd ${SEARCH}

MULTIPLE_NUM=1

for FILE in $(ls *.[0-9]) ; do
	EXT=$(echo ${FILE} | sed 's#.[0-9]##g' | awk -F "." '{ print $NF }')
	NEW=$(echo ${FILE} | sed "s#.${EXT}.[0-9]#.${MULTIPLE_NUM}#g" )
	#echo ${FILE} | awk -F . '{ print NF }'
	#EXT=$(echo ${FILE} | awk -F "." '{NF="";print}' | awk -F "." '{ print $NF }')
	echo " extension is $EXT "
	echo " new name is $NEW "
	echo "final name is ${NEW}_${TODAY}.${EXT} "
	mv ${FILE} ${NEW}_${TODAY}.${EXT}
	let MULTIPLE_NUM=${MULTIPLE_NUM}+1
done

for WEIRDO in $( ls *%3F* ) ; do 

	NEW=$(echo $WEIRDO | cut -d "%" -f1)
	mv -v $WEIRDO $NEW
done



}



###########################options
[ $# -lt 1 ] && usage
USEBOTH=1
INTERACT=1
PIXMAC=1
GOOGLE=1
SUPERIOR=1
echo $@

while getopts s:hgpbSi option
do
        case $option in
                s) SEARCH_DIRTY=${OPTARG} ;;
				g) GOOGLE=2 ;;
				p) PIXMAC=2 ;;
				b) USEBOTH=2 ;;
				i) INTERACT=2 ;;
				S) SUPERIOR=2 ;;
                h) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################

WEB_NUM=$((GOOGLE+PIXMAC))

if [[ ${USEBOTH} -eq 2 && ${WEB_NUM} -gt 2 ]]
	then
		echo "do not use the -b option with either the -g or -p options EVER!!! try again"
		exit 0
fi

if [ ${INTERACT} -eq 2 ]
	then
		interact
fi

SEARCH=$(echo $SEARCH_DIRTY | sed 's#\ #+#g')
SEARCH_NUM=$( echo ${SEARCH} | grep -i [a-z] | wc -l )

if [[ ${GOOGLE} -eq 2 && ${SEARCH_NUM} -gt 0 ]] 
	then
		google
		cleanup
elif [[ ${PIXMAC} -eq 2 && ${SEARCH_NUM} -gt 0 ]] 
	then
		pixmac
		cleanup
elif [[ ${SUPERIOR} -eq 2 && ${SEARCH_NUM} -gt 0 ]] 
	then
		superior
		cleanup
elif [[ ${USEBOTH} -eq 2 && ${SEARCH_NUM} -gt 0 ]]
	then		
		google
		cleanup
		pixmac
		cleanup
		superior
		cleanup		
elif [[ ${SEARCH_NUM} -lt 1 ]]
	then
		echo "i don't understand what you want"
fi


mv *google* ${SEARCH}_orig_page.html .list* ARCV/






