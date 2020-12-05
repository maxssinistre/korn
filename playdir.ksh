#!/bin/ksh

for T in $(ls); do
	mplayer $T
done
