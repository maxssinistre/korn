#!/bin/ksh

awk -F '"' '/href/ && /title/ && /data-rt/ { print $2 }' $@
