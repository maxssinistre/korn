#!/bin/ksh


############VARIABLES

DATE=$(date +%M%S)
WORK_LIST=.list1.log
PDF_DIR=/mnt/drive2/WESTMAGZ/PDF/
START_DIR=/mnt/drive2/WESTMAGZ/

############################

cd $START_DIR
mkdir $DATE
cd $DATE


######FUNCTION


function get_front {
NUM=$@
    	
		while [ ${NUM} -ge 0 ]
		do
			wget http://www.westmagz.com/?page=$NUM
			let NUM=$NUM-1
			
		done

}


function rip_links {

grep -o 'href="[^"]*'

}

function doit {
echo sssss
}



###########################options
[ $# -lt 1 ] && usage

while getopts i:d: option
do
      case $option in
           	d) NUM="$OPTARG" ;;
		i) get_front "$OPTARG" ;;
		*) usage;;
											
esac
done

shift $(expr $OPTIND - 1)

##########################################





cat index.* | rip_links | sed 's#href="#http://www.westmagz.com/#g' | grep -i pdf | grep -v ed2k | awk '! a[$0]++' >> $WORK_LIST


wget -m -i $WORK_LIST

find ./ -name '*.pdf' -exec mv {} ${PDF_DIR} \;


