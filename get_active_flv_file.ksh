#!/bin/ksh -x

DOWNLOAD_DIR=~/SINGULAR_VIDS

mkdir $DOWNLOAD_DIR

cd $DOWNLOAD_DIR

echo "this only works if one file is streaming and the file is fully cached. please type or cut and paste the filename youe want."
read OUT_FILEa


OUT_FILE=$(echo $OUT_FILEa | sed 's#\ #_#g').flv



cp -v /proc/$(lsof|grep Flash|sort -nk 8|tail -n1|awk '{print $2}')/fd/$(lsof|grep Flash|sort -nk 8|tail -n1|awk '{print $5}'|sed 's/[A-Za-z]//g') ${OUT_FILE}

#[exec] (ADHOC server connection)                      {rxvt -e /bin/ad_hoc_server.ksh  -rcfile ~/.profile}

