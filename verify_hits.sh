#!/bin/bash

instance=$1

#calculate the day need to verify is how many day ago and input here
date=$2

date2=`date -u -d "$date day ago" +"%Y_%m_%d_17_0"`
date=`echo "$date + 1" |bc`
date1=`date -u -d "$date day ago" +"%Y_%m_%d_16_50"`

mysql="/data/app/bimax/flow.sh run db${instance}_ mysql pw$instance -N -s -A"

total_hit=0
tmp=`mktemp`
echo "show tables like '%link_visit_action_2%'" | $mysql | while read table; do
	if [ "$table" \< "piwik_log_link_visit_action_$date2" -a "$table" \> "piwik_log_link_visit_action_$date1" ]; then
		hit=`echo "select count(*) from $table" | $mysql`
		total_hit=`echo "$total_hit + $hit" | bc`
		echo $total_hit > $tmp
		#echo $table
	fi
done

echo "total hit in $date2: "
cat $tmp
