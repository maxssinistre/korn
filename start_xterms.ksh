#!/bin/ksh


function usage {
echo '            
                Simple utility to open multiple xterms locally or remotely 
		-s server to open windows for. if nothing entered , locally opened
		-n number of xterms that are opened
'
 exit 0
}




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

	while [ ${NUMBER} -gt 0 ] ; do
	
		xterm -e /bin/bash -rcfile ~/.profile &
		let NUMBER=${NUMBER}-1

	done
	
elif [ -n ${SERVER} ] ; then

	while [ ${NUMBER} -gt 0 ] ; do
	
		xterm -e "ssh -Y $USER@${SERVER}" &
		let NUMBER=${NUMBER}-1

	done

fi
