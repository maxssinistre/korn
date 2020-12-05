#!/bin/ksh

 

 

WEBSITE=$@

 

FLODER_NAME_temp=$(echo $WEBSITE | awk -F "/" '{ print $NF }' | tr [:lower:] [:upper:] )
#FLODER_NAME_temp=$(echo $WEBSITE | sed 's#www##g' | cut -d "."  -f 1 | sed 's#http://##g' | tr [:lower:] [:upper:] )

 

#SCRIPT_NAME=$(echo ${FLODER_NAME_temp} | tr [:upper:] [:lower:] ).ksh

 

GENERIC_BLOG_LOCATION=/mnt/drive4/WEBSITES/BGHeavean/GENERIC/MYSPACE/

 

 

echo "the website is $WEBSITE"

 

echo "the folder name is $FLODER_NAME_temp , If that name is cool press enter, otherwise enter the new name.

here are the folders with similar name \n $(ls -d *$(echo $FLODER_NAME_temp | cut -c 1,2,3,4)* ) "

read temp_fold

#echo $temp_fold

 

FOLDER_NAME=${temp_fold:-$FLODER_NAME_temp}

 

#echo $FOLDER_NAME

 

 

SCRIPT_NAME=$(echo ${FOLDER_NAME} | tr [:upper:] [:lower:] ).ksh

 

mkdir -p $FOLDER_NAME/ARCH/HTM

 

cd $FOLDER_NAME

 

cp -v ${GENERIC_BLOG_LOCATION}/* ./

 

cat generic_space.ksh | sed "s#YOURWEBSITE#${WEBSITE}#g" > ${SCRIPT_NAME}

 

rm generic_space.ksh 

 

#cat  ${SCRIPT_NAME}

 

ksh -x ${SCRIPT_NAME}
