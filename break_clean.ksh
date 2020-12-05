#!/bin/ksh

HOLDING=/mnt/drive3/burn_temp
>list
find ./ -name '*.mp3' -size +100k | sed 's#\ #%20#g' >>list
find ./ -name '*.mp3' -size +100k -exec mv {} ${HOLDING} \; 

for Y in $(cat list) ; do 

	touch $Y
done
