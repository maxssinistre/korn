#!/bin/ksh


OPEN=0
DOWNY=0
ARCHIVE=0
WEB_APP=midori

function usage {

echo "

	To pull down a list of tumblr sites that match a search parameter

	i - Choose interactive option
	s - The subject that you are looking for. Enclose multiple words with quotes.
	o - choose to open tumblr search page in web browser
	d - to create new blog folders for the returned lists
	a - to archive the history of the blogs
	h - print this usuage statement

"
exit 0
}

function interactive {

echo "What is the subject you want to check on ? (enclose multiple words with quotes)"
read SUBJECTa

}


###########################options
[ $# -lt 1 ] && interactive
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts ihados: option
do
        case $option in
        i) interactive ;;
        s) SUBJECTa="$OPTARG" ;;
	o) OPEN=1 ;;
	d) DOWNY=1 ;;
	a) ARCHIVE=1 ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################





SUBJECT=$(echo ${SUBJECTa} | sed 's#\ #-#g')
[ $ARCHIVE -eq 1 ] && ARC="-a"

function get_it {

for SITE in $(cat ${SUBJECT}_list.txt) ; do 

	new_blog_install.ksh ${ARC} -w $SITE

done

}

function download_manager {

                        while [ $(ps -ef | egrep '(y[o]ut|w[g]et|k[s]h|\.[p]l)' | grep -v show_spe[c]ial | wc -l ) -ge 15 ] ;do
                                sleep 30
                        done
}

mkdir ${SUBJECT}

cd ${SUBJECT}

wget http://www.tumblr.com/tagged/${SUBJECT}?referring_page=404 -O ${SUBJECT}.tmp


cat ${SUBJECT}.tmp | awk -F '"' '/data-blog-url/ { print $2 }' >> ${SUBJECT}_list.txt

cat ${SUBJECT}_list.txt | awk '!a[$0]++' >> .tmp_${SUBJECT}_list.txt

mv .tmp_${SUBJECT}_list.txt ${SUBJECT}_list.txt

if [ $OPEN -eq 1 ] ; then

	${WEB_APP} ${SUBJECT}.tmp &

fi

sleep 5

rm ${SUBJECT}.tmp


if [ $DOWNY -eq 1 ] ; then

	get_it &

	download_manager

fi








#wget http://www.tumblr.com/tagged/weightlifting?referring_page=404
