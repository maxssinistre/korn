#!/bin/ksh

NUM=$@

for T in $(find -mmin ${NUM} -print) ; do

		xpdf $T
done
