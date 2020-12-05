#!/bin/ksh

INPUT=$@



cat ${INPUT} | awk -F '"' '/embed\/mail\// && /_myvideo/ && /mozallowfullscreen=/ { gsub ("https://videoapi.my.mail.ru/videos/embed","https://my.mail.ru") ; gsub ("_myvideo","video/_myvideo") ; print $12 }'
