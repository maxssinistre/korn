#!/bin/ksh 

DIR=$(pwd)

TODAY=$(date +%m%d%y%H%M%S)

function usage {

echo " A simple archiving utility

	-g tar and gzip the folders automatically 
	-b tar and bzip the folders automatically 
	-u unzip zip/tgz files
	-t tar the folders
	-z use the zip utility to zip the folders
	-d delete the folder or compessed file after processing
	-r use rar to compress the file
	-i will ask you what you want to do at start of process
	
"
exit 0
}

function answer {

ANSWER=1

}

function dome {

#echo $ANSWER
#echo $option

if [[ ${ANSWER} = 1 ]]

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

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do

	tar -cvzf ${T}_${TODAY}.tgz ${T} && dome ${T}

done

}

function yesir {

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do

	tar -cvzf ${T}_${TODAY}.tgz ${T} && dome ${T}
done

}

function buzzy {

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do

        tar -cvjf ${T}_${TODAY}.tbz ${T} && dome ${T}
done

}

function open {

for T in $(ls | egrep '(.tbz|.tar|.tgz|.zip|.rar)')  
	do 
		tardis $T && dome ${T} 	
	done
}

function tarnslash {

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do

        tar -cvf ${T}_${TODAY}.tar ${T} && dome ${T}
done

}

function tardis {

if [ $(echo $1 | awk '/.tgz/ { print $0 }'| wc -l) -ge 1 ]

then

	tar -xvzf $1

elif [ $(echo $1 | awk '/.tar/ { print $0 }'| wc -l) -ge 1 ]

then

	tar -xvf $1

elif [ $(echo $1 | awk '/.zip/ { print $0 }'| wc -l) -ge 1 ]

then

	unzip -oL $1

elif [ $(echo $1 | awk '/.tbz/ { print $0 }'| wc -l) -ge 1 ]

then

        tar -xjvf $1

elif [ $(echo $1 | awk '/.bz2/ { print $0 }'| wc -l) -ge 1 ]

then

        bunzip2 $1

elif [ $(echo $1 | awk '/.rar/ { print $0 }'| wc -l) -ge 1 ]

then

        unrar x -y $1

fi
}

function zippy {

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do

        zip -9 -r -v ${T}_${TODAY}.zip ${T} && dome ${T}
done

}

function rarbaby {

for T in $(ls -ltr | awk '/^d/ { print $NF }') ; do 

	rar a -m5 ${T}_${TODAY}.rar ${T} && dome ${T}
done
}

###########################options
[ $# -lt 1 ] && usage
test $( echo $@ | grep -o -i d ) && answer

echo $@

while getopts :dgbiutzr option
do
	case $option in
		d) answer ;;
		g) yesir ;;
		b) buzzy ;;
		u) open ;;
		t) tarnslash ;;
		z) zippy ;;
		r) rarbaby ;;
		i) interactive ;;
		*) usage;;
											
	esac
done

shift $(expr $OPTIND - 1)

##########################################





