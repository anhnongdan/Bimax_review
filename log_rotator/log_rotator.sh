#!/usr/bin/env bash

#rotate piwik for the ease of debugging.
# run as a cron job

#test
#log=test.log
#piwik_log=piwik.log

log=/data/bimax/pw2/log/log_rotator.log
piwik_log=/data/bimax/pw2/log/php/piwik.php

if [ ! -f $piwik_log ]; then
    echo "log file not found" >> $log
    exit 1
fi

timestamp=`date +%Y_%m_%d_%H`
rotated=${piwik_log}_$timestamp

if [ -f $rotated ]; then
    echo "rotated log file exists????" >> $log
    exit 1
fi

cp $piwik_log $rotated
cat /dev/null > $piwik_log
echo "rotated log at $timestamp" >> $log
