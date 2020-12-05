#!/bin/ksh

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
