#!/bin/ksh

cd /mnt/drive1/NICE_WEEK/

rm *

find /mnt/drive1/NICE_WEB/ -mtime -7 -size +50k '(' -iname '*.jp*' -o -iname '*.gif*' -o -iname '*.pn*' ')' -exec cp -v {} /mnt/drive1/NICE_WEEK/ \;


detox -r /mnt/drive1/NICE_WEEK/*
