#!/bin/ksh


HERM=$(pwd) 
ARCHIVE=0

function usage {

echo " This is a script to create new scripts and directory for dailymotion. Also copies in scripts for archiving entire blog and youtube and tumblr vids

	n - this is for you to put the name you want to use
	a - this is to put the account name 
	h - print this statement

"
exit 0
}

function archive {

echo $FOLDER_NAME
echo $HERM

cd ${HERM}/${FOLDER_NAME}

ksh auto_blog $WEBSITE
special_blog.pl -a -s $WEBSITE

ksh cleanup

}

###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts ha:n: option
do
        case $option in
        n) NAME_temp="$OPTARG" ;;
	a) ACCOUNT="$OPTARG" ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################
 

GENERIC_YOUTUBE=/mnt/drive1/GENERIC/DAILYMOTION/

echo "the youtube account is $NAME_temp"

 

if [ $(ls -d *$(echo $NAME_temp | cut -c 1,2,3,4,5,6,7,8)* | wc -l) -ge 1 ] ; then

	echo "the folder name is $NAME_temp , If that name is cool press enter, otherwise enter the new name. Here are the folders with similar name(s): 

$(ls -d *$(echo $NAME_temp | cut -c 1,2,3,4,5,6,7,8)* ) "

read temp_fold

else

	echo "the folder name is $NAME_temp "
	
fi 



FOLDER_NAME=${temp_fold:-$NAME_temp}
UPPERFOLDER=$(echo ${FOLDER_NAME} | tr [:lower:] [:upper:] )

#echo $FOLDER_NAME

 

 
NAMEN=$(echo ${FOLDER_NAME} | tr [:upper:] [:lower:] )
SCRIPT_NAME=${NAMEN}.ksh
ALLBACK_NAME=allback_${NAMEN}

 

mkdir -p ${UPPERFOLDER}

 

cd ${UPPERFOLDER}

 

cp -v ${GENERIC_YOUTUBE}/* ./

 

cat generic_you.ksh | sed "s#YOURWEBSITE#${ACCOUNT}#g" > ${SCRIPT_NAME}

cat all_back_you | sed "s#YOURWEBSITE#${ACCOUNT}#g" > ${ALLBACK_NAME} 

rm generic_you.ksh all_back_you

chmod -R 777 ../${UPPERFOLDER}
 

#ksh -x ${SCRIPT_NAME}



if [ ARCHIVE -eq 1 ] ; then

	echo "you choose to archive entire site...go get some coffee, this could take a while"
	archive

fi



#for T in $(ls /mnt/NASSER/drive2/GENERIC/BLOG/*) ; do FILENAME=$(echo $(basename $T )) ; echo "function $FILENAME {" ; echo ; echo 'echo "' ; cat $T ; echo ; echo "\" >> $FILENAME " ; echo "}" ; echo  ; doneME






function TESTING {

mkdir TEST
cd TEST
all_back
auto_blog
auto_blog_old
auto_blog_ver2
cleanup
download_countdown
generic_blog
get_tumblr_vids
get_youtube_archive

}
