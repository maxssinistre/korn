#!/bin/ksh


#functions

#for gathering info

function InFo {

echo "####"

SERVER=$@
echo "Gathering info for Server ${SERVER}"

echo "+++"
echo "PING"
echo "Pinging server" 
#/cygdrive/c/WINDOWS/system32/ping -s 4 $SERVER
#ping -s 4 $SERVER

#echo "+++"
#echo "NSLOOKUP"
#echo "doing Lookup for Server ${SERVER}"
#nslookup $SERVER

echo "+++"
echo "TRACEROUTE"
echo "Tracing Network Route for ${SERVER}"
#tracert -h 6 $SERVER
traceroute -h 6 $SERVER

echo "+++"
echo "NMAP"
echo "Checking ports for ${SERVER}"
nmap -T Aggressive -PN -sV -n -O -v ${SERVER}
#nmap  -sV -v -v -v  -p22,80,443,1352,3389,8082,8443 -T Polite -PB -sS -P0 ${SERVER}

echo "+++"
}

function generator {

RANGE=192.168.1
nmap -sP ${RANGE}.* | awk '/Nmap scan report/ && !/\(/  { print $NF }'

}

#VARIABLES

#TIME=$(date +%a%b%d%g_%k%M%S | tr -d [:cntrl:])
TIME=$(date +%a%b%d%g%k%M%S | tr "\ " "_")
LOGGING=output_${TIME}.log
list=$@

#program

touch $LOGGING

#listy="$(cat $list)"


if [ -z $listy ] ; then

	listy="$(generator)"

	for LISTING in $listy ; do
	        echo " checking ${LISTING}"
        	InFo $LISTING >> $LOGGING 2>&1
	done
elif [ -n listy ] ; then


	for LISTING in $(cat $list) ; do

		echo " checking ${LISTING}"
		InFo $LISTING >> $LOGGING 2>&1

	done 
fi
