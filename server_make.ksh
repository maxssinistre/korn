#!/bin/ksh

HOME_DIR=~/SERVERS

echo " What is the name of the server?"
read SERVER

cd "${HOME_DIR}"

echo "ssh -X -l odtwaph ${SERVER}" > ${SERVER}

chmod 755 ${SERVER}

ksh ${SERVER}
