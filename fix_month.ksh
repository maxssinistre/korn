#!/bin/ksh



function usage {
echo"
	This is for fixing downloaded filenames from mythweb site using mythweb_dnldr.ksh
	-o = the original string that you want to replace, make sure it is original enough(explicit) i.e.  -gen not  gen
	-n = the new string you want to use to replace with, can be almost anything but no # symbols allowed

note:this could be used for batch renaming of anything that matches

" 
exit 0 
}

###########################options
[ $# -lt 1 ] && usage
#test $( echo $@ | grep -o -i d ) && answer

#echo $@

while getopts :o:n: option
do
        case $option in
                o) ORIGINAL=${OPTARG} ;;
                n) NEW=${OPTARG} ;;
                *) usage;;

        esac
done

shift $(expr $OPTIND - 1)

for FILE in $(ls *${ORIGINAL}*) ; do 
        NEW_NAME=$(echo ${FILE} | sed "s#"${ORIGINAL}"#"${NEW}"#g") 
        mv -v ${FILE} ${NEW_NAME} 
done
