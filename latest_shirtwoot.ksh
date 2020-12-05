#!/bin/ksh

NUM=$@

cd /mnt/NASSER/drive4/SHIRT_WOOT/PICS/

xv -maxpect -root -quit -random $(ls -tr | tail -${NUM})
