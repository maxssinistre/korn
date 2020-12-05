#!/bin/ksh


ONE=$1
TWO=$2
THREE=$3
FOUR=$4

#HERM=/mnt/drive1/PLUMP_TEMP/SEARCHES
HERM=/mnt/drive1/PLUMP_TEMP/SUBJECT

DIR=$(echo ${1}${2}${3}${4} | tr [:lower:] [:upper:] | tr -d " " )

MAIN_LIST=/mnt/drive1/PLUMP_TEMP/SEARCHES/1_big_list.txt

mkdir -p ${HERM}/${DIR}

cd ${HERM}/${DIR}

#cat ${MAIN_LIST} | egrep -i "(${SUBJECT})" | shuf | head -30 > todat.txt ; parralell_youtube-dl.ksh -p 10 -l todat.txt

cat ${MAIN_LIST} | awk '{IGNORECASE=1} ; /'"$ONE"'/ && /'"$TWO"'/ && /'"$THREE"'/ && /'"$FOUR"'/ { print $0 }' | shuf | head -50 > todat.txt ; parralell_youtube-dl.ksh -p 10 -l todat.txt
