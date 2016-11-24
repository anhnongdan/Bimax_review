#!/bin/sh

mysql=`docker exec -it bimax_db1_1 mysql pw1 -s -A`

#take first argument for exam day

ar_type=$1
day="2016_$2"
output="archive_${type}_${day}"
ofile="${output}.txt"

echo "select idsite from piwik_site;" | $mysql | while read site; do
    #echo "select concat_ws(',', name, date1, date2, ts_archived) from piwik_archive_temp_${ar_type}_${day} where idsite=$site and name like 'Actions_actions';" | $mysql  >> $ofile
    #exec /usr/bin/python archive_blob.py $output $day
    echo "run test suite for site $site"
done


#echo "select concat_ws(\',\', name, date1, date2, ts_archived) from piwik_archive_temp_$type_2016_$day where idsite= and name like \"Actions_actions\";" | $mysql  >> file.txt

