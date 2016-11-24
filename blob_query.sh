mysql="mysql pw1 -N -s -A"

#this takes 2 arguments for archive type: (blob or numeric) 
# and archive day (in the year of 2016)
ar_type=$1
day="2016_$2"
output="/app/out/archive_${type}_${day}"
ofile="${output}.txt"

echo "select idsite from piwik_site;" | $mysql | while read site; do
    echo "select concat_ws(',', name, date1, date2, ts_archived) from piwik_archive_temp_${ar_type}_${day} where idsite=$site and name like 'Actions_actions';" | $mysql  >> $ofile
    #exec /usr/bin/python archive_blob.py $output $day
    #echo "run test suite for site $site"
done

