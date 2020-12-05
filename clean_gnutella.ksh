#!/bin/ksh

cd /mnt/drive2/gnutella_temp/

find ./ -mtime +5 -exec mv {} /mnt/drive3/OLD_gnutella/NEW/ \;
cd /mnt/drive3/OLD_gnutella/NEW/
mv *.mp3 *.MP3 *.m4a *.wma ../MP3/
mv *.WMV *.wmv *.avi *.rm *.asf *.mov *.mp* ../PROVA/
mv *.zip *.rar *.RAR *.ZIP ../ZIPS/	
cd PROVA
CHANGE_DIR.scr	
