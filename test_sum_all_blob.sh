#!/bin/sh

#This takes 1 parameter - the date for archiving 2016_11_23 for example

docker exec -it bimax_db1_1 sh /app/blob_query.sh blob $1

if [ -f /data/bimax/pw1/db/etc/out/archive_blob_${1}.txt ];
then
    mv /data/bimax/pw1/db/etc/out/archive_blob_${1}.txt /data/bimax/pw1/Bimax_review
else 
    echo "/app/blob_query.sh output fail"
    exit 0
fi

python archive_blob.py -i archive_blob_$1 -d $1
