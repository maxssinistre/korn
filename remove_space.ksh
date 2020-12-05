#!/bin/ksh

NAME=$@

mv "$NAME" $(echo "${NAME}" | tr -d [[:blank:]])
