#!/bin/ksh


cd /mnt/drive1/WEEKVIDS/

mkdir OLD
mkdir NEW

mv NEW/* OLD/

show_today.ksh -m -d /mnt/drive1/NICE_WEB -b -t -7 -c -D /mnt/drive1/WEEKVIDS/NEW


rm NEW/*-Frag*
rm -rf OLD


