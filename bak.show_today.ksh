#!/bin/ksh

#scripot to show pictures in directory


function usage {
echo '            
		Simple utility to show files in a directory using xv or 
		xanim. Shows files according to age according to your 
		options. Days variable must come first
		-v [+/- a number]use xv for viewing
		-x [+/- a number]use xanim for viewing
		-i interactive mode
		-d days old , use " +/- number"
'
 }

function num {
NUM=$@
}

function viewer {

NUM=$@
num

find ./ -mtime ${NUM} -print | egrep -i '(jpg|png)' | awk 'BEGIN {FS = "/"} ! a[ $NF ]++' | sed 's#\ #\\ #g' | xargs xv -maxpect
}

function slide {

NUM=$@
#num

find ./ -mtime ${NUM} -print | egrep -i '(jpg|png)' | awk 'BEGIN {FS = "/"} ! a[ $NF ]++' | sed 's#\ #\\ #g' | xargs xanim -f
}

function gq {
find ./ -mtime ${NUM} -print | egrep -i '(jpg|png)' | awk 'BEGIN {FS = "/"} ! a[ $NF ]++' | sed 's#\ #\\ #g' | xargs gqview -f -t -s 
}

function interactive {

echo "What viewer to use ? (xv or xanim)"
read CHOICE

echo "How many days back ?( use plus or minus and the number)"
read NUM

if $CHOICE == xanim 
then
	slide
else
	viewer
fi
}

###########################options
[ $# -lt 1 ] && usage

while getopts d:ivxg option
do
      case $option in
           	d) num "$OPTARG" ;;
		v) viewer "$OPTARG" ;;
		x) slide ;;
		g) gq "$OPTARG" ;;
		i) interactive ;;
		*) usage;;
											
esac
done

shift $(expr $OPTIND - 1)

##########################################


echo $NUM



