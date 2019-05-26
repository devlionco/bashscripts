#!/usr/bin/env bash
# https://aws.amazon.com/en/getting-started/tutorials/backup-to-s3-cli/  - aws instalations and configuration
# script will make backup db and save dump in S3 each 3 days

DBUSER='' #mysql DB username
DBPASSWD='' #mysql DB username
DBNAME='' #mysql DB name
HOST='' #mysql DB hostname or ip
OUTPUT="/var/backups/"
BUCKETNAME='' #bucketname
DATE=`date +%Y-%m-%d`
DATEDEL=`date --date="3 days ago" +%F`

rm -f $OUTPUT*.gz > /dev/null 2>&1
mysqldump --force --opt --user=$DBUSER --password=$DBPASSWD -h$HOST --databases $DBNAME > $OUTPUT/$DATE.$db.sql
gzip $OUTPUT/$DATE.$DBNAME.sql

/usr/local/aws/bin/aws  s3 cp $OUTPUT/$DATE.$DBNAME.sql.gz s3://$BUCKETNAME/
/usr/local/aws/bin/aws s3 rm s3://$BUCKETNAME/$DATEDEL.$DBNAME.sql.gz #remove old
