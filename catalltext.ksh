#!/bin/ksh

cat $(file $(find ./ -type f -exec grep -Iq . {} \; -print ) | awk -F ":" '/ASCII/ && !/HTML|Korn|executable|playlist/ { print $1 }') | awk '!a[$0]++'
