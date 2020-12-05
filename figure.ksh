#!/bin/ksh
FILE=links
DATE=$(date +%M%S)
AUTOMATED_LIST=refresh_list.txt


#for creating config file for t-naiton file download

#echo "What is the topic number ? "
#read TOP_NUMBER

#echo "how many pages ?"
#read count

#Download first file

wget http://www.t-nation.com/tmagnum/figureImages.jsp?pageNo=0

####get foldername and make foldername move files to working folder

DIRECT=$(grep -i title *figureImages.jsp* |head -1 |sed 's/<[a-zA-Z\/][^>]*>//g' | sed 's#TMAGNUM \FORUMS\ -\ ##g' | sed 's#TESTOSTERONE\ NATION\ -##g' | cut -d ":" -f2 | sed 's#\ ##g' | tr -d [:punct:])

mkdir $DIRECT
mv *.jsp* $DIRECT
cd $DIRECT

#Download other files

#count=$(cat *figureImages.jsp* | awk -F\<a '/Last/ { print $NF }' | grep -o 'pageNo=[^"Last]*' | awk '! a[$0]++' | sed 's#pageNo=##g')
count=10
#AMOUNT=57000
      	
		while [ ${count} -gt 0 ]
		do
			wget http://www.t-nation.com/tmagnum/figureImages.jsp?pageNo=$count
			let count=$count-1
			
		done

####next step , download the needed files
####that is being done above, no lets put the top number into the file for the automated update script

echo $TOP_NUMBER >> ../$AUTOMATED_LIST

####pull links out of do files
#for DO in $(ls *.jsp*) ; do
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

cat *.jsp* | grep -o 'src="[^"]*' | sed 's#src="##g' | egrep -i '(gif|jpg|png)' >> $FILE.1



###cleanup file and configure
awk '{

   if ($0 in theArray || $0 ~ "crm.gif")
        next

    gsub(/)/,"\\)",$0)
    gsub(/\(/,"\\(",$0)

    theArray[$0] = "wget -rkm -np http://www.t-nation.com" $0

}

END {

    for (i in theArray)
        print theArray[i]

}' $FILE.1 > $FILE.2


sed "s#'#\\\'#g" links.2 > links.bat

####download time !!!!!

. ./$FILE.bat

####cleanup files
tar -cvzf archive_$RANDOM.tgz *figureImages.jsp* $FILE*
rm -rf *figureImages.jsp*
rm -f $FILE*

#echo "${TOP_NUMBER}" >>top_number.txt

#CRAZY=$(basename $(pwd))
#echo "The new files are in the ${CRAZY} directory."
cd -

####cleanup duplicates in automated list

#cat $AUTOMATED_LIST | awk '! a[$0]++' >> .temp

#mv .temp $AUTOMATED_LIST
