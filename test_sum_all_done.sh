#!/usr/bin/env bash

#This takes 1 parameter
# the date for archiving 2016_11_23 for example

type='numeric'

docker exec -it bimax_db1_1 sh /app/db_query.sh $type $1 'done%'

if [ -f /data/bimax/pw1/db/etc/out/archive_${type}_${1}.txt ];
then
    mv /data/bimax/pw1/db/etc/out/archive_${type}_${1}.txt /data/bimax/pw1/Bimax_review
else
    echo "/app/db_query.sh output fail"
    exit 1
fi

python temp_archive_analyzer.py -i archive_${type}_$1 -d $1 -m "done flag for plugins"
