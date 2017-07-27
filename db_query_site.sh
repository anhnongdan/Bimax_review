#!/usr/bin/env bash

instance=$5

mysql="/data/app/bimax/flow.sh run db${5}_ mysql pw$5 -N -s -A"

#Copy this file to /data/bimax/pw#/db/etc/

#this takes 3 arguments for archive type: (blob or numeric)
# and archive day (e.g: 2016_11_24)
# and metric (e.g: Actions_actions, done, done%. This argument accepts wildcard %)

ar_type=$1
day=$2
metric=$3
site=$4

if [ $# -lt 5 ]; then
    echo "!! Invalid input argument"
    exit 1
fi

output="${site}_archive_${ar_type}_${day}_$metric"
ofile="${output}.txt"



echo "select concat_ws(',', name, date1, date2, ts_archived) from piwik_archive_${ar_type}_temp_${day} where idsite=$site and name like '$metric';" | $mysql  >> $ofile
