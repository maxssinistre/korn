#!/bin/ksh

for T in $(ls ) ; do mplayer -idx $T ; done
