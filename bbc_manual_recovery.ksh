#!/bin/ksh


# recover failed bbc streams


#awk -F '"' 'BEGIN{IGNORECASE = 1 } /programme__titles/  && /annie/ { print $4 }' bbc_html*



INPUT=$@




awk -F '"' 'BEGIN{IGNORECASE = 1 } /programme__titles/  && /'"${INPUT}"'/ { print $6 }' bbc_html* | awk '!a[$0]++'







