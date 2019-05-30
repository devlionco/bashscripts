#!/usr/bin/env bash
BACKUPTIME=`date +\%Y-\%m-\%d-\%H-\%M-\%S`
PROJECT=myproject
DBNAME=mydb
DBUSERNAME=username
DBPASSWORD=username
DBHOST=localhost
PATHTOMOODLE=/var/www/moodle
PATHTOMOODLEDATA=/var/www/moodledata
mysqldump -h $DBHOST -u $DBUSERNAME -p$DBPASSWORD $DBNAME | gzip > $PROJECT$BACKUPTIME.gz
zip moodle_$PROJECT_-$BACKUPTIME.zip $PATHTOMOODLE -r
zip moodledata_$PROJECT_-$BACKUPTIME.zip $PATHTOMOODLEDATA -r

