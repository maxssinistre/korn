#!/bin/ksh
export DISPLAY=127.0.0.1:0
cd /usr/share/wallpapers/ 
find ./ -type f |xargs /usr/X11R6/bin/xv -maxpect -root -quit -random 
