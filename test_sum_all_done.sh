#!/usr/bin/env bash

#This takes 2 parameters
# 1 the date for archiving 2016_11_23 for example
# 2 the instance number of docker that is inspected, this used for both db# and pw#

type='numeric'
date=$1
metric='done%'
instance=$2

#docker exec -it bimax_db1_1 sh /app/db_query.sh $type $1 'done%'
sh db_query.sh $type $1 'done%' $2

#if [ -f /data/bimax/pw1/db/app/out/archive_${type}_${1}_done%.txt ];
#then
#    mv /data/bimax/pw1/db/app/out/archive_${type}_${1}_done%.txt $PWD
#else
#    echo "/app/db_query.sh output fail"
#    exit 1
#fi

python temp_archive_analyzer.py -i pw${instance}_archive_${type}_${1}_done% -d $1 -m "done flag for plugins"
