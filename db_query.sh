#!/bin/sh

mysql="docker exec -it bimax_db1_1 mysql pw1 -N -s -A"

#take first argument for exam day

type=$1
day=2016_$2
output=archive_$type_$day

echo "select idsite from piwik_site;" | $mysql | while read site; do
    echo "select concat_ws(\',\', name, date1, date2, ts_archived) from piwik_archive_temp_$type_$day where idsite=$site and name like \"Actions_actions\";" | $mysql  >> $output.txt
    exec `/usr/bin/python archive_blob.py $output $day
done


#echo "select concat_ws(\',\', name, date1, date2, ts_archived) from piwik_archive_temp_$type_2016_$day where idsite= and name like \"Actions_actions\";" | $mysql  >> file.txt

