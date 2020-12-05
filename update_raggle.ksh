#!/bin/ksh

cd ~/.raggle/

mv feeds.yaml feeds.bak

rm feeds.yam*

raggle --import-opml google-reader-subscriptions.xml

echo "done import!!"
