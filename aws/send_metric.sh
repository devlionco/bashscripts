#!/bin/bash

# Send all project instances concurrent users stats to AWS CloudWatch.
# Use direct SQL to query each instance for users count in the last 5 min.

if [[ -n $1 ]]
then
  instances="$1"
else
  instances="math sciences computerscience demo biology chemistry physics"
fi

echo "Date:";date +"%Y-%m-%dT%T.000Z";

for project_instance in $instances
do
    echo "Instance: ${project_instance}"

    ### ConcurrentUsers
    usercount=`mysql -h projectl-moodle-prod-41.cy0vnngkcwdt.eu-west-1.rds.amazonaws.com -D moodle_${project_instance} -e "SELECT COUNT(DISTINCT u.id) AS usercount FROM mdl_user AS u WHERE (UNIX_TIMESTAMP() - u.lastaccess) < 60 * 5" -s --skip-column-names`

    /usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --region eu-west-1 --metric-name ConcurrentUsers_${project_instance} --namespace PROJECT_NAME --value $usercount
    #/usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --metric-name ConcurrentUsers_${project_instance} --namespace PROJECT_NAME --value $usercount --timestamp `date +"%Y-%m-%dT%T.000Z"`

    echo "concurrent ${project_instance} users = $usercount";

    ### ConvertToPDFQueue
    queuelength=`mysql -h projectl-moodle-prod-41.cy0vnngkcwdt.eu-west-1.rds.amazonaws.com -D moodle_${project_instance} -e "SELECT COUNT(*) AS "assignfeedback_editpdf_queue" FROM mdl_task_adhoc WHERE component='assignfeedback_editpdf' " -s --skip-column-names`

    /usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --region eu-west-1 --metric-name ConvertToPDFQueue_${project_instance} --namespace PROJECT_NAME --value $queuelength
    #/usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --metric-name ConvertToPDFQueue_${project_instance} --namespace PROJECT_NAME --value $queuelength --timestamp `date +"%Y-%m-%dT%T.000Z"`

    echo "Assignment feedback queue length for ${project_instance} office submissions = $queuelength";

    ### Adhoc tasks running
    adhoctasks=`mysql -h projectl-moodle-prod-41.cy0vnngkcwdt.eu-west-1.rds.amazonaws.com -D moodle_${project_instance} -e "SELECT COUNT(*) AS "count" FROM mdl_task_adhoc" -s --skip-column-names`

    /usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --region eu-west-1 --metric-name AdHocTasks_${project_instance} --namespace PROJECT_NAME --value $adhoctasks
    #/usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --metric-name AdHocTasks_${project_instance} --namespace PROJECT_NAME --value $adhoctasks --timestamp `date +"%Y-%m-%dT%T.000Z"`

    echo "AdHoc tasks running for ${project_instance} = $adhoctasks";

    ### Automatic backup status=OK
    ## status[o] = Error
    ## status[1] = OK
    ## status[2] = Unfinished
    ## status[3] = Skipped
    ## status[4] = Warning
    ## status[5] = Not yet run
    autobackup=`mysql -h projectl-moodle-prod-41.cy0vnngkcwdt.eu-west-1.rds.amazonaws.com -D moodle_${project_instance} -e "SELECT COUNT(bc.courseid) AS statuscount FROM mdl_backup_courses bc WHERE bc.laststatus=1 GROUP BY bc.laststatus " -s --skip-column-names`

    /usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --region eu-west-1 --metric-name AutobackupOK_${project_instance} --namespace PROJECT_NAME --value $autobackup
    #/usr/bin/aws cloudwatch put-metric-data --profile AmazonCloudWatchAgent --metric-name AdHocTasks_${project_instance} --namespace PROJECT_NAME --value $autobackup --timestamp `date +"%Y-%m-%dT%T.000Z"`

    echo "AutoBackup finished OK for ${project_instance} = $autobackup";

done
