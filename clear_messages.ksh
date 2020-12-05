#!/bin/ksh

# script to clear messges out of /var/spool/clientmqueue


TODAY=$(date +%Y%m%d%H%M%S)
HERM=/home/salsa/SYSTEM_LOGS/

cd $HERM

tar -cvzf /mnt/drive3/mail_$TODAY.tgz /var/spool/clientmqueue/* /var/spool/mail/*

#rm -f /var/spool/clientmqueue/*

cd /var/spool/clientmqueue

for FILE in $( ls df* ) ; do

	> $FILE

done


cd /var/spool/mail

for FILE in $( ls ) ; do

	> $FILE

done










