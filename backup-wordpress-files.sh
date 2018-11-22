#!/usr/bin/env bash

#/bin/bash
wppath=/var/www/wp  #path to your wordpress
backuppath=/var/backups #backup path
backupdatetime=date +\%Y-\%m-\%d-\%H-\%M-\%S

#----ACCESS TO DB ------#
DBNAME=dwordpress
DBUSERNAME=dbusername
DBPASSWORD=dbpassword

#----Backup of Wordpress DB----#
mysqldump $DBNAME -u $DBUSERNAME -p$DBPASSWORD | gzip > /var/backups/wordpress-db-$backupdatetime.sql.gz

#----Backup of Wordpress Files----#
zip -r $backuppath/wordpress-data-$backupdatetime.zip $wppath



# addd to crontab
#4 10 * * * /bin/bash /home/yourusername/backup.sh
#2 2 * * * find /var/backups/* -mtime +7 -exec rm {} \;