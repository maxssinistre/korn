#!/bin/ksh


HERM=$(pwd) 
ARCHIVE=0

function usage {

echo " This is a script to create new scripts and directory for blog sites from wordpress , tumblr , and blogspot sites. Also copies in scripts for archiving entire blog and youtube and tumblr vids

	w - this is for you to put the website in there
	a - this is to do the archiving of a site
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

while getopts ihaw: option
do
        case $option in
        i) interactive ;;
        w) WEBSITEa="$OPTARG" ;;
	a) ARCHIVE=1 ;;
        h) usage;;
        *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

##########################################
 

WEBSITE=$(echo ${WEBSITEa} |  sed 's#/$##g' )

FLODER_NAME_temp=$(echo $WEBSITE | sed 's#www##g' | cut -d "."  -f 1 | sed 's#http://##g' | sed 's#https://##g' |tr [:lower:] [:upper:] )

 

#GENERIC_BLOG_LOCATION=/mnt/drive2/WEBSITES/BGHeavean/GENERIC/BLOG/
#GENERIC_BLOG_LOCATION=/mnt/NASSER/drive2/GENERIC/BLOG/
GENERIC_BLOG_LOCATION=/mnt/drive1/GENERIC/BLOG/

 

echo "the website is $WEBSITE"

 

if [ $(ls -d *$(echo $FLODER_NAME_temp | cut -c 1,2,3,4,5,6,7,8)* | wc -l) -ge 1 ] ; then

	echo "the folder name is $FLODER_NAME_temp , If that name is cool press enter, otherwise enter the new name. Here are the folders with similar name(s): 

$(ls -d *$(echo $FLODER_NAME_temp | cut -c 1,2,3,4,5,6,7,8)* ) "

read temp_fold

else

	echo "the folder name is $FLODER_NAME_temp "
	
fi 



FOLDER_NAME=${temp_fold:-$FLODER_NAME_temp}


#echo $FOLDER_NAME

 

 
NAMEN=$(echo ${FOLDER_NAME} | tr [:upper:] [:lower:] )
SCRIPT_NAME=${NAMEN}.ksh
ALLBACK_NAME=allback_${NAMEN}

 

mkdir -p $FOLDER_NAME/ARCH/HTM

 

cd $FOLDER_NAME

 

cp -v ${GENERIC_BLOG_LOCATION}/* ./

 

cat generic_blog.ksh | sed "s#YOURWEBSITE#${WEBSITE}#g" > ${SCRIPT_NAME}

cat all_back | sed "s#YOURWEBSITE#${WEBSITE}#g" > ${ALLBACK_NAME} 

rm generic_blog.ksh
rm all_back

 

#cat  ${SCRIPT_NAME}

 

ksh -x ${SCRIPT_NAME}



if [ ARCHIVE -eq 1 ] ; then

	echo "you choose to archive entire site...go get some coffee, this could take a while"
	archive

fi



#for T in $(ls /mnt/NASSER/drive2/GENERIC/BLOG/*) ; do FILENAME=$(echo $(basename $T )) ; echo "function $FILENAME {" ; echo ; echo 'echo "' ; cat $T ; echo ; echo "\" >> $FILENAME " ; echo "}" ; echo  ; done






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
