#!/bin/ksh

for T in $(ls) ; do

#mencoder -idx $T -ovc xvid -oac copy -o $T.fixed
mencoder -idx $T -ovc copy -oac copy -o $T.fixed
done

