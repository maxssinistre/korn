#!/bin/ksh

#HOME=$(pwd)

MAX=$(ls -R | egrep '(pdf|jpg|flv|htm|txt)' | wc -l)

time_check() {

#!/bin/ksh

PUM=0

if [ ${PUM} -le ${MAX} ]
then
	while [ ${MAX} -gt ${PUM} ]
	do
        	PUM=$(ls -R | egrep '(pdf|jpg|flv|htm|txt)' | wc -l)
        	clear
        	echo "So far ${PUM} of ${MAX} files have been converted"
        	sleep 10
	done
else
        	clear
        	echo " The maximum number of files, ${MAX} , have been converted"
        	exit
fi

}


archive.ksh -t -d

wget -rkm -np www.tyngdlyftning.net
wget -rkm -np http://www.strength.nu/

time_check &

cd www.tyngdlyftning.net/

for PIC in $(find ./ -type f -print) ; do

      WORK=$(file $PIC | grep image | cut -d ":" -f1)
      WORK2=$(file $PIC | grep PDF | cut -d ":" -f1)
        WORK3=$(file $PIC | grep -i video | cut -d ":" -f1)
        WORK4=$(file $PIC | grep -i html | cut -d ":" -f1)
        WORK5=$(file $PIC | grep -i asci | cut -d ":" -f1)

      mv $WORK $WORK.jpg 2>/dev/null 
      mv $WORK2 $WORK2.pdf 2>/dev/null 
        mv $WORK3 $WORK3.flv 2>/dev/null        
        mv $WORK4 $WORK4.htm 2>/dev/null        
        mv $WORK5 $WORK5.txt 2>/dev/null 
 
done
cd -

cd www.strength.nu

for PIC in $(find ./ -type f -print) ; do

      WORK=$(file $PIC | grep image | cut -d ":" -f1)
      WORK2=$(file $PIC | grep PDF | cut -d ":" -f1)
        WORK3=$(file $PIC | grep -i video | cut -d ":" -f1)
        WORK4=$(file $PIC | grep -i html | cut -d ":" -f1)
        WORK5=$(file $PIC | grep -i asci | cut -d ":" -f1)

      mv $WORK $WORK.jpg 2>/dev/null 
      mv $WORK2 $WORK2.pdf 2>/dev/null 
        mv $WORK3 $WORK3.flv 2>/dev/null        
        mv $WORK4 $WORK4.htm 2>/dev/null        
        mv $WORK5 $WORK5.txt 2>/dev/null 
 
done
cd -

archive.ksh -u -d

