#!/bin/ksh




for FILKE in $(ls | egrep -i '(.mp|.nuv|.avi|.mkv)') ; do 

	mencoder $FILKE -oac pcm -ovc raw -o output.avi

	divx_encode.ksh -i output.avi -o $FILKE.fixed.avi

	rm output.avi
done

