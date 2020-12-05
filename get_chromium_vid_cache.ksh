cp -v $(for T in $(find ~/.cache/chromium/ -mmin -30) ; do echo $T ; file $T ; done | egrep -i '(flash|vid)' | cut -d ":" -f1) ~/TEMP/CHROMIUM_CACHE/
