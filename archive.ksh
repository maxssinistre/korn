#!/bin/ksh 

DIR=$(pwd)

TODAY=$(date +%m%d%y%H%M%S)

ANSWER=0
YESIR=0
BUZZY=0
OPEN=0
TARNSLASH=0
ZIPPY=0
RARBABY=0
INTERACTIVE=0
LISTEM=0


function usage {

echo " A simple archiving utility

	-g tar and gzip the folders automatically 
	-b tar and bzip the folders automatically 
	-u unzip zip/tgz files
	-t tar the folders
	-z use the zip utility to zip the folders
	-l list contents of zip file
	-d delete the folder or compessed file after processing
	-r use rar to compress the file
	-i will ask you what you want to do at start of process
	-f the file that you want to compress or decompress
	
"
exit 0
}

function dome {

#echo $ANSWER
#echo $option

if [ ${ANSWER} -eq 1 ]

	then
		echo " completed processing ${1}. It will now be deleted ...."
		rm -rf ${1}

else
		echo "processing completed on ${1} " 

fi
}

function interactive {

echo "Do you want to also delete the directories ? must be YES or NO"
read ANSWER

echo "which files do you want do work on ? it can be a space separated list, wilcards are allowable, but no spaces in names "
read LIST

for T in $(ls -ltr ${LOSTY}| awk '/^d/ { print $NF }') ; do

	tar -cvzf ${T}_${TODAY}.tgz ${T} && dome ${T}

done

}

function listem {

#http://www.cyberciti.biz/faq/list-the-contents-of-a-tar-or-targz-file/
#http://superuser.com/questions/462788/read-the-contents-of-a-zipped-file-without-extraction

LOSTY=$@


for FIN in $LOSTY ; do 

    echo "Archive name is $FIN ...."
    echo


    if [ $(echo ${FIN} | egrep -i '(tar.gz|.tgz)' | wc -l ) -ge 1 ] ; then
    
        tar -ztvf ${FIN} | more
        
    elif [ $(echo ${FIN} | egrep -i '(tar.bz|.tbz)' | wc -l ) -ge 1 ] ; then
    
        tar -jtvf ${FIN} | more
        
    elif [ $(echo ${FIN} | grep -i tar | egrep -iv '(bz|gz)' | wc -l ) -ge 1 ] ; then
    
        tar -tvf ${FIN} | more
        
    elif [ $(echo ${FIN} | grep -iv tar | egrep -i zip | wc -l ) -ge 1 ] ; then

        unzip -l ${FIN} | more
        
    elif [ $(echo ${FIN} | grep -iv tar | grep -i gz | wc -l ) -ge 1 ] ; then

        zcat ${FIN} | more
        
    elif [ $(echo ${FIN} | grep -iv tar | grep -i gz | wc -l ) -ge 1 ] ; then

        bzcat ${FIN} | more
        
    else 
         echo
        #echo "This doesn't appear to be an archive....."
        echo "${FIN} looks like $(file $FIN | awk -F ":" '{ print $NF }') , not an archive."
        echo
        
    fi
    
done
        
}

function yesir {

LOSTY=$@

for T in $(ls -ltrd $LOSTY | awk '/^d/ { print $NF }') ; do

	tar -cvzf ${T}_${TODAY}.tgz ${T} && dome ${T}
done

}

function buzzy {

LOSTY=$@

for T in $(ls -ltrd ${LOSTY}| awk '/^d/ { print $NF }') ; do

        tar -cvjf ${T}_${TODAY}.tbz ${T} && dome ${T}
done

}

function open {

LOSTY=$@

echo " ${LOSTY} in open "

for T in $(ls -d ${LOSTY} | egrep '(.bz2|.tbz|.tar|.tgz|.zip|.rar)')  
	do 
		tardis $T && dome ${T} 	
	done
}

function tarnslash {

LOSTY=$@

for T in $(ls -ltrd ${LOSTY}| awk '/^d/ { print $NF }') ; do

        tar -cvf ${T}_${TODAY}.tar ${T} && dome ${T}
done

}

function tardis {

LOSTY=$@


if [ $(echo ${LOSTY} | awk '/.tgz/ { print $0 }'| wc -l) -ge 1 ]

then

			tar -xvzf ${LOSTY}

elif [ $(echo ${LOSTY} | awk '/.tar/ { print $0 }'| wc -l) -ge 1 ]

then
			tar -xvf ${LOSTY}
elif [ $(echo ${LOSTY} | awk '/.zip/ { print $0 }'| wc -l) -ge 1 ]

then
			unzip -oL ${LOSTY}
elif [ $(echo ${LOSTY} | awk '/.tbz/ { print $0 }'| wc -l) -ge 1 ]

then
			tar -xjvf ${LOSTY}
elif [ $(echo ${LOSTY} | awk '/.bz2/ { print $0 }'| wc -l) -ge 1 ]

then

			bunzip2 ${LOSTY}
elif [ $(echo ${LOSTY} | awk '/.rar/ { print $0 }'| wc -l) -ge 1 ]

then

        unrar x -y ${LOSTY}

fi
}

function zippy {

LOSTY=$@

for T in $(ls -ltrd ${LOSTY}| awk '/^d/ { print $NF }') ; do

        zip -9 -r -v ${T}_${TODAY}.zip ${T} && dome ${T}
done

}

function rarbaby {

LOSTY=$@

for T in $(ls -ltrd ${LOSTY}| awk '/^d/ { print $NF }') ; do 

	rar a -m5 ${T}_${TODAY}.rar ${T} && dome ${T}
done
}

###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts :dgbiutzrlf: option
do
	case $option in
        d) ANSWER=1 ;;
        g) YESIR=1 ;;
        b) BUZZY=1 ;;
        u) OPEN=1 ;;
        t) TARNSLASH=1 ;;
        z) ZIPPY=1 ;;
        r) RARBABY=1 ;;
        l) LISTEM=1 ;;
        i) INTERACTIVE=1 ;;
	f) FILE_TEM="$OPTARG" ;;
	*) usage;;
											
	esac
done

TEMP=$(ls)
FILE_2=${FILE_TEM:-$TEMP}

FILE=$(echo $FILE_2 | sed 's#/$##g')
#FILE=${FILE_TEM}

echo " the file var is $FILE "

shift $(expr $OPTIND - 1)

##########################################



if [ $ANSWER -eq 1 ] ; then

echo "	answer is $ANSWER "
	
fi

if [ $LISTEM -eq 1 ] ; then

	listem $FILE
	
fi

if [ $YESIR -eq 1 ] ; then

	yesir $FILE
	
fi

if [ $BUZZY -eq 1 ] ; then

	buzzy $FILE
	
fi	

if [ $OPEN -eq 1 ] ; then

	open $FILE
	
fi	

if [ $TARNSLASH -eq 1 ] ; then

	tarnslash $FILE
	
fi

if [ $ZIPPY -eq 1 ] ; then

	zippy $FILE
	
fi

if [ $RARBABY -eq 1 ] ; then

	rarbaby $FILE
	
fi

if [ $INTERACTIVE -eq 1 ] ; then

	interactive 
	
fi

