#!/bin/ksh

ANSWER=0


while getopts du option
do
        case $option in
        d) ANSWER=1 ;;
        *) usage;;

        esac
done






#mkisofs -L -l -allow-lowercase -allow-multidot -N -v -d -o ck.iso ToCd/



FOLDERS_LIST=$(ls -ltr | awk '/^d/ { print $NF }' )



	for STARTER in ${FOLDERS_LIST} ; do

#		if [ $(du -s ${STARTER} | awk '{print $1}') -ge 4247640 ] ; then
		if [ $(du -s ${STARTER} | awk '{print $1}') -ge 4244440 ] ; then

			if [ ${ANSWER} -eq 1 ] ; then
#				mkisofs -volid "${STARTER}" -R -T -L -l -no-cache-inodes -full-iso9660-filenames -iso-level 4 -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/ &&  rm -rf ${STARTER}
				mkisofs -volid "${STARTER}" -R -T -allow-limited-size -allow-leading-dots -l -no-cache-inodes -full-iso9660-filenames -iso-level 4 -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/ &&  rm -rf ${STARTER}
				echo "deleting folder  ${STARTER}"
			elif [ ${ANSWER} -eq 0 ] ; then

#				 mkisofs -volid "${STARTER}" -R -T -L -l -no-cache-inodes -full-iso9660-filenames -iso-level 4 -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/
				 mkisofs -volid "${STARTER}" -R -T -allow-limited-size -allow-leading-dots -l -no-cache-inodes -full-iso9660-filenames -iso-level 4 -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/

			fi
        	fi

	done



#OLD commands


#       mkisofs -volid "${STARTER}" -J -R -T -L -l -no-cache-inodes -full-iso9660-filenames -iso-level 4 -joliet -joliet-long -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/

#	/usr/bin/genisoimage -gui -graft-points -volid K3b data project -volset  -appid K3B THE CD KREATOR (C) 1998-2010 SEBASTIAN TRUEG AND MICHAL MALEK -publisher  -preparer  -sysid LINUX -volset-size 1 -volset-seqno 1 -sort /tmp/kde-salsa/k3bD15970.tmp -rational-rock -hide-list /tmp/kde-salsa/k3bs15970.tmp -no-cache-inodes -full-iso9660-filenames -iso-level 3 -path-list /tmp/kde-salsa/k3bj15970.tmp


#	mkisofs -max-iso9660-filenames -volid "anthony back" -J -L -l -no-cache-inodes -full-iso9660-filenames -iso-level 3 -joliet -joliet-long -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/


#	mkisofs -graft-points -volid "anthony back" -volset  -appid DODO -publisher  -preparer  -sysid LINUX -volset-size 1 -volset-seqno 1 -sort /tmp/kde-salsa/k3bpw2619.tmp -rational-rock -hide-list /tmp/kde-salsa/k3bKB2619.tmp -joliet -joliet-long -hide-joliet-list /tmp/kde-salsa/k3bYk2619.tmp -no-cache-inodes -full-iso9660-filenames -iso-level 3 -path-list /tmp/kde-salsa/k3bwS2619.tmp


#	mkisofs -L -l -allow-lowercase -allow-multidot -N -v -d -o ${STARTER}.iso ${STARTER}/

















