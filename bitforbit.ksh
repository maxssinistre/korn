#!/bin/ksh

#FUNCTIONS

function readcd_raw {

#cdrdao read-cd --read-raw --datafile ${NAME}.bin --device 5,0,0 --driver generic-mmc-raw ${NAME}.toc
cdrdao read-cd --read-raw --datafile ${NAME}.bin --device /dev/sr0 --driver generic-mmc-raw ${NAME}.toc

}

function write_cd {

#cdrdao write --eject --speed 24 --device 5,0,0 --driver generic-mmc ${NAME}.toc
cdrdao write --eject --speed 24 --device /dev/sr0 --driver generic-mmc ${NAME}.toc

}

function burncd_loop {

echo "how many copies? "
read COPIES

while [ ${COPIES} -gt 0 ]
	do	
		echo "press enter when the cd is in the tray"
		read
		write_cd
		let COPIES=${COPIES}-1
	done
echo "all done"
}


echo "what is the name of the image? (just the name, extension not needed)"
read NAME

mkdir ${NAME}
cd ${NAME}

readcd_raw 

eject /dev/sr0

echo "do u want to burn this now?"
read ANSWER

if [ $ANSWER == yes ]
	then 	
			burncd_loop
	else
		echo "all done"
fi
