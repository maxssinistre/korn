NUM=$1
TIM=$2
TIME=${TIM:-30}
HERM=$(pwd) ; for T in $(ls -ltr | awk '/^drw/ { print $NF }') ; do echo $T ; cd $T ; fbi -t ${TIME} -a $(find ./ -mtime -${NUM} -iname '*.jpg' ) ; cd $HERM ; done 
