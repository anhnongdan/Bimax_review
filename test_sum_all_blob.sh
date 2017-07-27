#!/bin/sh

#This takes 2 parameters
# the date for archiving: 2016_11_23 for example
type='blob'

date=$1
instance=$2
metric=$3

#docker exec -it bimax_db1_1 sh /app/db_query.sh $type $date $metric
#docker exec -it bimax_db1_1 sh /app/db_query.sh $type $1 'done%'
sh db_query.sh $type $date $metric $instance


#if [ -f /data/bimax/pw1/db/etc/out/archive_${type}_${date}_$metric.txt ];
#then
#    mv /data/bimax/pw1/db/etc/out/archive_${type}_${date}_$metric.txt /data/bimax/pw1/Bimax_review
#else 
#    echo "/app/db_query.sh output fail"
#    exit 1
#fi

python temp_archive_analyzer.py -i pw${instance}_archive_${type}_${date}_$metric -d $date -m $metric
