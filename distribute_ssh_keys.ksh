#!/bin/ksh

#  Anthony Hamilton 02-Nov-2009   added ability to read from credentials file or config file
#								  added provision for differant usernames	
#								  added some cleanup	

# Script to Distribute SSH Keys
# (This presumes you have a known Private Key and a LIST FILE in the format :
#  servername1		password1		username1
#  servername2		password2		username2
#  . . . etc. . . .

##	IDENTIFY THE LIST FILE AS ARG #1
SERV="$1"
SERVERLIST_IN=${SERV:-${HOME}/.credentials}


##	CREATE RESULTS LOG NAME
export OUTFILE="./Results_`date '+%Y%M%H%M'`"
 
##	INTEGRITY CHECKS - DISPLAY RUNTIME ERRORS IF NEEDED
if [ $# -lt 1  -o  ! -e "$1" ]
        then
        echo " using .credentials file in your home directory for info"
		echo ""
       # exit 1
fi
##	MAKE SURE THE SECONDARY SCRIPT IS PRESENT
if [ ! -f setup_keys.ksh  -o  ! -x setup_keys.ksh ]
	then
	echo " HELP : Script  setup_keys.ksh  not found !"
	echo ""
        exit 1
fi

   cat $SERVERLIST_IN | while read linein
   do
	## GET PASSWORD FROM CONFIG FILE
	export PASS="`echo $linein | awk '{print $2}'`"
	#Decide which parse to use
	if [ $# -lt 1  -o  ! -e "$1" ]
		then
			## GET  SERVER  NAME FROM CONFIG FILE
			export serv="`echo $linein | awk '{print $1}' | awk -F "@" '{print $2}'`"
			## GET  USER  NAME FROM CONFIG FILE
			export username="`echo $linein | awk '{print $1}' | awk -F "@" '{print $1}'`"
		else
			## GET  SERVER  NAME FROM CONFIG FILE
			export serv="`echo $linein | awk '{print $1}'`"
			## GET  USER  NAME FROM CONFIG FILE
			export username="`echo $linein | awk '{print $3}'`"
	fi		
	./setup_keys.ksh -u $username -r $serv -p $PASS

   done 2>&1 > $OUTFILE
