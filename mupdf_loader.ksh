#!/bin/ksh

#to load pdf files into mupdf


echo "paste the full path to the file here....."

read PATH


/usr/bin/mupdf $PATH
