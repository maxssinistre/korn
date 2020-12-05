#!/bin/ksh

echo "What is the name of your new script? "
read NAME
#echo "What is your name ?"
#read AUTHOR
echo "Write a one line description..."
read DESCR

##variables
#START=/cygdrive/c/Documents\ and\ Settings/anthony.hamilton/My\ Documents/PERL
START=~/PERL_SCRIPTS
VERSION=1.0
DATE=$(date)
AUTHOR=$(whoami)
CRAZY=$RANDOM
#notetab=/cygdrive/c/Documents\ and\ Settings/anthony.hamilton/my_apps/NoteTab\ Light/NoteTab.exe
notetab=gedit

function header {
echo "#!/usr/bin/perl -Tw
#------------------------------------------------------
# Script Name: ${NAME}.pl
# Script Version: ${VERSION}
# Date: ${DATE}
# Author: ${AUTHOR}
# Description: "${DESCR}"
# Revision history:
#       1.0/$DATE : original version
#------------------------------------------------------

#------------------------------------------------------
# Function:
# Version Added:
# Input:
# Output:
# Description:
#------------------------------------------------------

"
}


cd "${START}"/

if ls "$START/${NAME}.pl" > /dev/null 2>&1
	then
		touch "$START/${NAME}_${CRAZY}.pl"	
		chmod 700 "$START/${NAME}"*
		header >> $START/${NAME}_${CRAZY}.pl
		echo "An original exist with the name ${NAME}. Changing the name of this 
one to ${NAME}_${CRAZY}.pl . Check your versions and merge as appropiate.." 
		echo " Press enter to continue"
		read
		gedit "$START/${NAME}_${CRAZY}.pl"		
		#vi "$START/${NAME}_${CRAZY}.pl"
	else
		touch "$START/${NAME}.pl"
                chmod 700 "$START/${NAME}"*		
		header >> $START/${NAME}.pl
		gedit "$START/${NAME}_${CRAZY}.pl"		
		#vi "$START/${NAME}.pl"
fi


