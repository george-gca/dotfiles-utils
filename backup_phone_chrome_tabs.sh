#!/bin/bash
# Created by: Adriano Gil
#             George Araújo (george.gcac@gmail.com)
# must have:
# phone
#   - chrome open
#   - connected to pc
#   - debug mode enabled
#   - accepted connections from this host
# PC
#   - adb installed
if [[ $# -gt 0 ]]; then
  target_file=$1 # File that will store all URL from mobile
else
  target_file="tabs_from_phone.txt" # File that will store all URL from mobile
fi

if (! hash adb 2>/dev/null); then
  echo -e "adb package not found. Install it with:\n\tsudo apt install adb"
  exit 1
fi

adb forward tcp:9222 localabstract:chrome_devtools_remote
wget -O tabs.json http://localhost:9222/json/list

cat tabs.json | grep 'url' | tr ',' ' ' |  awk '{print $2}' > $target_file
rm tabs.json

session_size=$(cat $target_file | wc -l)
echo 'Saved '$session_size' open tabs from Android Google Chrome into file '$target_file
