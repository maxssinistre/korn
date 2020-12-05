#!/bin/ksh

#variable
#PICS=$(ls | egrep -i '(.jpg|.gif)')

#move stuff


#links section

NOW=$(date +%Y%m)
HARM=$(echo $HOME | sed 's#\ #\\ #g')

cd ~/Desktop/
mkdir ~/Desktop/newlink_$NOW
mv -u *.url ./newlink_$NOW/
mv -u *.URL ./newlink_$NOW/
cd ./newlink_$NOW/
mkdir SOURCEFORGE
mv *SourceForge* ./SOURCEFORGE/
mkdir EBAY
mv *eBay* ./EBAY/
mkdir GOOGLE
mv *Google* ./GOOGLE/
mv $(ls | grep 'end time' | cut -d " " -f 1 | sed 's#$#*#g') ./EBAY/
mkdir TMAG
mv TESTOSTERONE* ./TMAG/
cd -
cd ~/

#picture_section

cd ~/Desktop/
mkdir ./newpic_$NOW
mv -u *.jpg ./newpic_$NOW
mv -u *.JPG ./newpic_$NOW
mv -u *.gif ./newpic_$NOW
mv -u *.GIF ./newpic_$NOW
mv -u *.png ./newpic_$NOW
mv -u *.PNG ./newpic_$NOW
cd ./newpic_$NOW
mkdir SHIRT_WOOT
mv -v *Detail* SHIRT_WOOT/
cd -
cd ~/

#file organizing

mv -u ~/Desktop/*.exe ~/My\ Documents/app_download/
mv -u ~/Desktop/*.gz ~/My\ Documents/app_download/
mv -u ~/Desktop/*.tgz ~/My\ Documents/app_download/
mv -u ~/Desktop/*.tar ~/My\ Documents/app_download/
mv -u ~/Desktop/*.rar ~/My\ Documents/app_download/
mv -u ~/Desktop/*.bz2 ~/My\ Documents/app_download/
mv -u ~/Desktop/*.msi ~/My\ Documents/app_download/
mv -u ~/Desktop/*.iso ~/My\ Documents/app_download/
mv -u ~/Desktop/*.rpm ~/My\ Documents/app_download/

mv -u ~/Desktop/*.zip ~/My\ Documents/app_download/
mv -u ~/Desktop/*.ZIP ~/My\ Documents/app_download/
mv -u ~/Desktop/*.jar ~/My\ Documents/app_download/a1200/

mv -u ~/Desktop/*.ksh ~/My\ Documents/simple_scripts/
mv -u ~/Desktop/*.mp3 ~/My\ Documents/music/
mv -u ~/Desktop/*.MP3 ~/My\ Documents/music/

mv -u ~/Desktop/google-reader-subscriptions.xml ~/.raggle/


mv -u ~/Desktop/*.txt ~/My\ Documents/TEXT/
mv -u ~/Desktop/*.rtf ~/My\ Documents/TEXT/
mv -u ~/Desktop/*.pdf ~/My\ Documents/PDF/
mv -u ~/Desktop/*.chm ~/My\ Documents/PDF/
mv -u ~/Desktop/*.ps ~/My\ Documents/PDF/
mv -u ~/Desktop/*.doc ~/My\ Documents/WORD_DOC/
mv -u ~/Desktop/*.xls ~/My\ Documents/EXCEL/
mv -u ~/Desktop/*.csv ~/My\ Documents/EXCEL/

mv -u ~/Desktop/*.lnk ~/Start\ Menu/Shortcuts/




#mv -u ~/Desktop/
#mv -u ~/Desktop/
#mv -u ~/Desktop/
#mv -u ~/Desktop/
