# Bimax_review
Assure that everything is working fine

A bunch of shell and python scripts to query directly to the DB and 
list out the result to help visual assessment of the archiving process.

Files are sparated for each table, and this needs to be fixed.

#Before 2017-07-20 Flow:
+ Copy db_query and db_query_site into /data/bimax/pwx/db/app/
+ Check script (sum_all_done, etc.) will call that script to query db
+ db_query output the result to a file to db/app 
+ need to copy over and run the analyze script 
=> What's right:
+ Run the query by calling flow.sh
+ out put file in this folder

#Note:
This need /data/app/bimax to be setup before running (call flow.sh).



