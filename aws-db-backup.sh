#!/bin/bash

# Log file location
log=/efs-disk/backups/backups.log
# Backup file locations
output=/efs-disk/backups
dbname=dbanme
dbusername=admin
dbpassword=dbpass
dbhost=aws.clrxtxnwdnv9.eu-central-1.rds.amazonaws.com
date=`date +%Y-%m-%d-%H`
# Remove old backup files
datedel=`date --date="7 days ago" +%F-%H`
pathmoodledata=/efs-disk/moodledata
bucketname="your_bucket_name"


echo ${date} >> ${log}

#make mysqldump and copy to s3
rm -f ${output}/*.sql.gz
mysqldump -h ${dbhost} -u ${dbusername} -p"${dbpassword}" ${dbname} | gzip > ${output}/${date}.${dbname}.sql.gz
aws s3 cp ${output}/${date}.${dbname}.sql.gz s3://${bucketname} &>> ${log}

#zip moodledata and copy to s3
rm -f ${output}/*.moodledata.zip
zip ${output}/${date}.moodledata.zip ${pathmoodledata} -r
aws s3 cp ${output}/${date}.moodledata.zip s3://${bucketname} &>> ${log}

#remove old backups on s3
aws s3 rm s3://${bucketname}/${datedel}.moodledata.zip  &>> ${log}
aws s3 rm s3://${bucketname}/${datedel}.${dbname}.sql.gz &>> ${log}