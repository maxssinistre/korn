#!/bin/ksh

# script to clear messges out of /var/spool/clientmqueue


cd /var/spool/clientmqueue

tar -cvzf /mnt/drive3/mail_$RANDOM.tgz /var/spool/clientmqueue/*

rm -f /var/spool/clientmqueue/*

