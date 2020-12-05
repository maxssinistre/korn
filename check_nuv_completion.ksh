#!/bin/ksh

for T in $(ls *.nuv) ; do 
	ls -ltrh ${T}*  
	read  
done 
