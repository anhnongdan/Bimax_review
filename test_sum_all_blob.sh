#!/bin/sh

#This takes 2 parameters
# the date for archiving: 2016_11_23 for example
type='blob'

date=$1
metric=$2

docker exec -it bimax_db1_1 sh /app/db_query.sh blob $type $date $metric

if [ -f /data/bimax/pw1/db/etc/out/archive_${type}_${date}_$metric.txt ];
then
    mv /data/bimax/pw1/db/etc/out/archive_${type}_${date}_$metric.txt /data/bimax/pw1/Bimax_review
else 
    echo "/app/db_query.sh output fail"
    exit 1
fi

python temp_archive_analyzer.py -i archive_${type}_${date}_$metric -d $date -m $metric
