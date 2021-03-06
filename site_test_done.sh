#!/usr/bin/env bash
#This takes 2 parameter
# the date for archiving: 2016_11_23 for example
# the idsite calculated
# instance number of docker
type='numeric'

date=$1
site=$2
instance=$3

#docker exec -it bimax_db1_1 sh /app/db_query_site.sh $type $date 'done%' $site

sh db_query_site.sh $type $date 'done%' $site $instance

#if [ -f /data/bimax/pw1/db/etc/out/${site}_archive_${type}_${1}.txt ];
#then
#    mv /data/bimax/pw1/db/etc/out/${site}_archive_${type}_${1}.txt /data/bimax/pw1/Bimax_review
#else
#    echo "/app/db_query_site.sh output fail"
#    exit 1
#fi

python temp_archive_analyzer.py -i ${site}_archive_${type}_${1}_done% -d $1 -m "done flag for plugins"
