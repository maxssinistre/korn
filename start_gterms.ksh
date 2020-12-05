#!/bin/ksh


function usage {
echo '            
                Simple utility to open multiple xterms locally or remotely 
		-s server to open windows for. if nothing entered , locally opened
		-n number of xterms that are opened
'
 exit 0
}

TERM_COMMAND="dbus-launch gnome-terminal "
#TERM_COMMAND="gnome-terminal "
#TERM_COMMAND="xterm -e"
TTEMP_SCRIPT=./temp_${RANDOM}




###########################options
[ $# -lt 1 ] && usage

while getopts :s:n: option
do
      case $option in

		s) SERVER="${OPTARG}" ;;
		n) NUMBER_TEMP="${OPTARG}" ;;
                *) usage;;

esac
done

shift $(expr $OPTIND - 1)

##########################################

NUMBER=${NUMBER_TEMP:-1}


if [ -z ${SERVER} ] ; then

	echo ${TERM_COMMAND}

	while [ ${NUMBER} -gt 0 ] ; do
	
		echo " --tab " 
		let NUMBER=${NUMBER}-1

	done
	
elif [ -n ${SERVER} ] ; then

	echo ${TERM_COMMAND}

	while [ ${NUMBER} -gt 0 ] ; do
	
		echo "--tab -e \"ssh -Y $USER@${SERVER}\" " &
		let NUMBER=${NUMBER}-1

	done

fi >> ${TTEMP_SCRIPT}

cat ${TTEMP_SCRIPT} | tr "\n" " " >>  ${TTEMP_SCRIPT}_2

sh ./${TTEMP_SCRIPT}_2

rm ${TTEMP_SCRIPT} ${TTEMP_SCRIPT}_2
