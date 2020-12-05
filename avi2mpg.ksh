#!/bin/ksh
#ffmpeg -sameq -ab 128 -vcodec mpeg2video -i $1 $1.mpg

#mencoder $1 -of mpeg -ovc lavc  -vf scale=640:480 -oac copy -o $1.mpg
#mencoder $1 -of mpeg -ovc lavc  -vf scale=800:600 -oac copy -o $1.mpg
mencoder $1 -of mpeg -ovc lavc  -vf scale=1024:768 -oac copy -o $1.mpg
