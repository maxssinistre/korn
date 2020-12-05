#!/bin/ksh

DIR=$@

for T in $(find ${DIR}/ -name '*.mp3' -print) ; do
	mplayer -idx $T
done 
