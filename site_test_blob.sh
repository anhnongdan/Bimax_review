#!/usr/bin/env bash

#This takes 3 parameters
# the date for archiving: 2016_11_23 for example
# the idsite calculated
type='blob'

date=$1
site=$2
metric=$3

docker exec -it bimax_db1_1 sh /app/db_query_site.sh $type $date $metric $site

if [ -f /data/bimax/pw1/db/etc/out/${site}_archive_${type}_${date}_$metric.txt ];
then
    mv /data/bimax/pw1/db/etc/out/${site}_archive_${type}_${date}_$metric.txt /data/bimax/pw1/Bimax_review
else
    echo "/app/db_query_site.sh output fail"
    exit 1
fi

python temp_archive_analyzer.py -i ${site}_archive_${type}_${date}_$metric -d $1 -m $metric
