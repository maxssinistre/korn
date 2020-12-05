#!/bin/ksh
FILE=links
DATE=$(date +%M%S)
AUTOMATED_LIST=refresh_list.txt


[ $# -lt 1 ] && usage

while getopts :n: option
do
     case $option in
               n) NUM="$OPTARG" ;;
               *) usage;;

esac
done

shift $(expr $OPTIND - 1)

####functions


####create the automated list

wget http://www.musclemayhem.com/forums/forumdisplay.php?f=$NUM

PUMP=$(grep -o '<title[^*]*' *${NUM}* | sed 's#title##g' | sed 's#\ ##g' | tr -d [:punct:])

mkdir $PUMP

mv *${NUM}* $PUMP

cd $PUMP

cat *${NUM}* | grep -o 'href="s[^*]*"' | grep title | cut -d '"' -f2 | cut -d '=' -f3 >> $AUTOMATED_LIST

mv forumdisplay.php* forumdisplay_${DATE}

########

function get_the_files {

TOP_NUMBER=$@

#Download first file

wget http://www.musclemayhem.com/forums/showthread.php\?t=${TOP_NUMBER}\&page=0

####get foldername and make foldername move files to working folder

DIRECT=$(grep -o '<title[^*]*' *${TOP_NUMBER}* | sed 's#&gt##g;s#&lt##g;s#title##g;s#\ -\ Muscle\ Mayhem\ Bodybuilding\ Forums##g;s#\ ##g'| tr -d [:punct:])

mkdir $DIRECT
mv *$TOP_NUMBER* $DIRECT
cd $DIRECT

#Download other files

county=$(cat *${TOP_NUMBER}* | grep Page | head -2 | tail -1 | cut -d ">" -f2 | awk '{ print $4}' | sed 's#</td##g' | tr -d [:cntrl:])
count=${county:-5}
#AMOUNT=57000

               while [ ${count} -gt 0 ]
               do
                       wget http://www.musclemayhem.com/forums/showthread.php\?t=${TOP_NUMBER}\&page=$count
                       let count=$count-1

               done

####next step , download the needed files
####that is being done above, now lets put the top number into the file for the automated update script

echo $TOP_NUMBER >> ../$AUTOMATED_LIST

####pull links out of do files
#for DO in $(ls *.do*) ; do
#
#
#perl -ne 'if (/src="([^"]*)"/) { print "$1\n"; }' $DO >> $FILE
#
#done
#
####separate out gifs jpeg and png
#egrep -i '(gif|jpg|png)' $FILE >> $FILE.1
#
###this is the new and improved way to do the above 2 steps

cat *show* | grep -o 'src="[^"]*' | sed 's#src="##g' | egrep -i '(gif|jpg|png)' | grep http |awk '!a[$0]++' >> $FILE
cat *show* | grep -o 'href="[^"]*' | sed 's#href="##g' | grep attachment | cut -d ";" -f2,3 | awk '!a[$0]++' | sed 's#^#http://www.musclemayhem.com/forums/attachment.php?#g' >> $FILE


####download time !!!!!

wget --tries=2 -nc -i $FILE

####cleanup files

#first clean attachment names

for T in $(ls attachment.php*) ; do 
	NAMEN=$(ls $T | tr -d [:alpha:] | tr -d [:punct:]) 
	mv ${T} ${NAMEN}.jpg 
done

#now archive old files

tar -cvzf archive_$RANDOM.tgz *$TOP_NUMBER*
rm -rf *$TOP_NUMBER*
rm -f $FILE*

echo "${TOP_NUMBER}" >>top_number.txt

CRAZY=$(basename $(pwd))
echo "The new files are in the ${CRAZY} directory."
cd -

####cleanup duplicates in automated list

cat $AUTOMATED_LIST | awk '! a[$0]++' >> .temp

mv .temp $AUTOMATED_LIST
}



function show_new {

echo "Do you want to see new pics?"
read ANSWER

       if echo $ANSWER |grep -q -i YES
       then
               echo "How far back should i search?"
               read OLD
               find ./ -mtime -${OLD} -name '*.jp*' -print | awk 'BEGIN {FS = "/"} ! a[ $NF ]++' |xargs xv -maxpect
       else
               echo " All done then"
       fi

}


for CON in $(cat $AUTOMATED_LIST) ;
do
       get_the_files $CON
done


#show_new
