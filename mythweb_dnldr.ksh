#!/bin/ksh


TODAY=$(date +%m%d%y%H%M%S)
TEMP_FILE=.temp
MYTH_WEBSITE=http://192.168.1.100/mythweb/tv/recorded?sortby=airdate
TODAY_OUTPUT=recorded_${TODAY}




wget ${MYTH_WEBSITE} -O ${TODAY_OUTPUT}




	for T in $(grep x-title ${TODAY_OUTPUT} | cut -d '"' -f4 | grep -v recorded | awk -F "/" '{print $5"/"$6}') ; do 
		echo "searching $T"  
		grep -A 25 "\<a\ class=\"x-pixmap\"\ href=\"/mythweb/tv/detail/${T}\"\ title=\"Recording\ Details\"" ${TODAY_OUTPUT} > ${TEMP_FILE}
		R_SHOW_NAME=$(grep x-title ${TEMP_FILE} | cut -d ">" -f 3 | sed 's#</a$##g' | sed 's#\ #_#g')
		R_SHOW_DATE=$(grep x-airdate ${TEMP_FILE} | cut -d ">" -f 2 | sed 's#</td$##g' | sed 's#\ ##g')
#		R_SHOW_DESC=$(grep valign ${TEMP_FILE} | cut -d ">" -f 2 | sed 's#</td$##g' | sed 's#\ ##g' | cut -c 1-210)
		R_SHOW_DESC=$(grep valign ${TEMP_FILE} | cut -d ">" -f 2 | sed 's#</td$##g' | sed 's#\ #_#g')
#		R_SHOW_TITLE=$(grep x-subtitle ${TEMP_FILE} | cut -d ">" -f 3 | sed 's#</a$##g' | sed 's#\ #_#g' | cut -c 1-100)
		R_SHOW_TITLE=$(grep x-subtitle ${TEMP_FILE} | cut -d ">" -f 3 | sed 's#</a$##g' | sed 's#\ #_#g')
		echo ${R_SHOW_NAME}
		echo ${R_SHOW_DATE}
		echo ${R_SHOW_DESC}
		echo ${R_SHOW_TITLE}

			if [ $(echo ${R_SHOW_DESC} | wc -c) -gt 220 ] ; then
				R_SHOW_DESC=$(grep valign ${TEMP_FILE} | cut -d ">" -f 2 | sed 's#</td$##g' | sed 's#\ ##g' | cut -c 1-210)
			fi

		D_NAME=$(echo ${R_SHOW_NAME}-${R_SHOW_TITLE}-${R_SHOW_DESC}-${R_SHOW_DATE}.nuv | sed 's#--#-#g')
		D_LINK=$(grep "title=\"Direct Download" ${TEMP_FILE} | cut -d '"' -f2)
		wget --user-agent=Mozilla --tries=1 ${D_LINK} -O ${D_NAME}
		#read
	done


rm ${TODAY_OUTPUT} ${TEMP_FILE}





# http://192.168.1.100/mythweb/tv/recorded?sortby=airdate




#<a class="x-pixmap" href="/mythweb/tv/detail/1055/1291420800" title="Recording Details"

#\<a\ class=\"x-pixmap\"\ href=\"/mythweb/tv/detail/${T}\"\ title=\"Recording\ Details\"
