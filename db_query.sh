#!/usr/bin/env bash

instance=$4

mysql="/data/app/bimax/flow.sh run db${4}_ mysql pw$4 -N -s -A"

#Copy this file to /data/bimax/pw#/db/etc/

#this takes 4 arguments for archive type: (blob or numeric)
# and archive day (e.g: 2016_11_24)
# and metric (e.g: Actions_actions, done, done%. This argument accepts wildcard %)
# and docker instance 

ar_type=$1
day=$2
metric=$3

if [ $# -lt 4 ]; then
    echo "!! Invalid input argument"
    exit 1
fi

output="pw${4}_archive_${ar_type}_${day}_$metric"
ofile="${output}.txt"

echo "select idsite from piwik_site;" | $mysql | while read site; do
    echo "select concat_ws(',', name, date1, date2, ts_archived) from piwik_archive_${ar_type}_temp_${day} where idsite=$site and name like '$metric';" | $mysql  >> $ofile
    #/usr/bin/python archive_blob.py $output $day
    #echo "run test suite for site $site"
done
